import 'dart:async';

import 'package:flutter/material.dart';

import '../chat/widgets/pixel_loader.dart';
import '../ide/terminal/terminal_instance.dart';
import '../ide/terminal/terminal_service.dart';
import '../ide/terminal/terminal_view.dart';
import '../kernel/claude_code/claude_environment.dart';
import '../kernel/claude_code/local_claude_io.dart';
import '../network/network_proxy_io.dart';
import '../theme/app_theme.dart';
import 'workspace.dart';

/// The agents shown as Claude Code's own terminal (see
/// [Workspace.inTerminal]): each one's `claude --resume`, drawn as Warp
/// draws its terminal.
class AgentTerminals extends ChangeNotifier {
  final Map<String, TerminalService> _services = {};

  /// Until the terminal of a session stopped has let it go.
  final Map<String, Future<void>> _stopping = {};

  /// [thread]'s terminal, once started.
  TerminalInstance? of(AgentThread thread) => _services[thread.id]?.active;

  /// Starts [thread]'s terminal, unless it runs.
  void ensure(AgentThread thread) {
    final id = thread.id;
    if (id == null || _services.containsKey(id)) return;
    final cwd = thread.record?.cwd ?? thread.project.path;
    final service = _services[id] = TerminalService(root: cwd, warp: true);
    unawaited(_start(service, id, cwd));
  }

  Future<void> _start(TerminalService service, String id, String cwd) async {
    await _stopping[id];
    final cli = await LocalClaude.locate();
    final proxy = await NetworkProxy.instance.environment();
    if (!identical(_services[id], service)) return;
    // Always with full access, as the chat's runs (see ClaudeCodeKernel).
    final arguments = ['--resume', id, '--dangerously-skip-permissions'];
    service.create(
      config: TerminalLaunchConfig(
        name: 'Claude Code',
        executable: cli.throughShell ? 'cmd.exe' : cli.executable,
        arguments: cli.throughShell
            ? ['/c', cli.executable, ...arguments]
            : arguments,
        cwd: cwd,
        env: {
          ...cli.environment,
          ...proxy,
          ...ClaudeEnvironment.stateDirectory(cli.environment, cwd: cwd),
        },
      ),
    );
    notifyListeners();
  }

  /// Stops the terminal of the session [id], for its chat to go on with
  /// it.
  Future<void> stop(String id) async {
    final service = _services.remove(id);
    if (service == null) return;
    service.dispose();
    notifyListeners();
    // ponytail: a fixed beat for Claude Code to go once hung up, not its
    // exit awaited (disposing drops the PTY's exit); await it if a chat
    // ever starts before the terminal let the session go.
    final stopped = _stopping[id] = Future.delayed(
      const Duration(milliseconds: 500),
    );
    await stopped;
    if (identical(_stopping[id], stopped)) _stopping.remove(id);
  }

  @override
  void dispose() {
    for (final service in _services.values) {
      service.dispose();
    }
    _services.clear();
    super.dispose();
  }
}

/// An agent's pane as Claude Code's terminal: its title bar, then the
/// terminal.
class AgentTerminalPane extends StatefulWidget {
  const AgentTerminalPane({
    super.key,
    required this.terminals,
    required this.thread,
    required this.title,
    this.leading,
    this.trailing,
    this.inset = 12,
  });

  final AgentTerminals terminals;
  final AgentThread thread;

  /// What its title bar says: where it is, and its name.
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final double inset;

  @override
  State<AgentTerminalPane> createState() => _AgentTerminalPaneState();
}

class _AgentTerminalPaneState extends State<AgentTerminalPane> {
  @override
  void initState() {
    super.initState();
    widget.terminals.ensure(widget.thread);
  }

  @override
  void didUpdateWidget(AgentTerminalPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.terminals.ensure(widget.thread);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppMetrics.titleBarHeight,
          child: Padding(
            padding: EdgeInsets.only(left: widget.inset, right: 4),
            child: Row(
              children: [
                ?widget.leading,
                Expanded(
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ?widget.trailing,
              ],
            ),
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: ListenableBuilder(
                listenable: widget.terminals,
                builder: (context, _) {
                  final instance = widget.terminals.of(widget.thread);
                  if (instance == null) {
                    return const Center(child: PixelLoader.agent(size: 16));
                  }
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) instance.focus();
                  });
                  return TerminalView(instance, key: ObjectKey(instance));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
