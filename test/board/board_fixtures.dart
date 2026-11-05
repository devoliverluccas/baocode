import 'package:baocode/board/board_data.dart';
import 'package:baocode/workspace/companies.dart';
import 'package:baocode/workspace/workspace.dart';

/// As in the user's companies.json.
const lunar = Company('LUNAR', '/lu', color: 0xffba68c8, icon: 'moon');
const promov = Company('PROMOV', '/p', color: 0xffffd54f, icon: 'work');
const stark = Company('STARK', '/s', color: 0xfff06292, icon: 'rocket');

/// ~15 conversations of 3 companies and 6 projects (one in none), in
/// every [BoardColumn], [now] the time they are from.
List<BoardThread> boardFixtures({DateTime? now}) {
  final at = now ?? DateTime.now();
  const hub = Project('hub-lunar', '/lu/hub-lunar');
  const shopp = Project('RM Shopp (Ecommerce)', '/lu/rm-shopp');
  const dashboard = Project('dashboard', '/p/dashboard');
  const agent = Project('agent-ia', '/p/agent-ia');
  const os = Project('stark-os', '/s/stark-os');
  const notes = Project('notas', '/n/notas');
  BoardThread t(
    Project project,
    String title,
    ThreadStatus status,
    Duration age, {
    bool active = false,
    bool archived = false,
    bool pinned = false,
    ({int added, int removed})? diff,
    String kernel = 'claude-code',
  }) => BoardThread(
    project: project,
    title: title,
    status: status,
    updatedAt: at.subtract(age),
    company: project.path.startsWith('/lu')
        ? lunar
        : project.path.startsWith('/p')
        ? promov
        : project.path.startsWith('/s')
        ? stark
        : null,
    active: active,
    archived: archived,
    pinned: pinned,
    diff: diff,
    kernel: kernel,
  );
  const m = Duration(minutes: 1);
  return [
    t(hub, 'Material comercial', ThreadStatus.running, m * 2, active: true),
    t(
      hub,
      'Copy da landing com a nova oferta de verão e o banner da home',
      ThreadStatus.needsInput,
      m * 5,
      kernel: 'codex',
      active: true,
    ),
    t(
      shopp,
      'Checkout Pix',
      ThreadStatus.unread,
      m * 12,
      diff: (added: 186, removed: 4),
    ),
    t(shopp, 'Frete grátis', ThreadStatus.idle, m * 40, active: true),
    t(
      dashboard,
      'Demanda do Matheus no relatório',
      ThreadStatus.running,
      m * 1,
      active: true,
      pinned: true,
      diff: (added: 42, removed: 7),
    ),
    t(
      dashboard,
      'Correções de segurança P1',
      ThreadStatus.needsInput,
      m * 20,
      kernel: 'codex',
    ),
    t(dashboard, 'Hyperdrive no D1', ThreadStatus.idle, m * 60 * 26),
    t(
      agent,
      'Worker travando no Redis',
      ThreadStatus.unread,
      m * 90,
      diff: (added: 12, removed: 30),
    ),
    t(agent, 'Logs do Coolify', ThreadStatus.idle, m * 60 * 5, active: true),
    t(agent, 'Prompt do agente v2', ThreadStatus.idle, m * 60 * 24 * 9),
    t(
      os,
      'Kernel scheduler',
      ThreadStatus.running,
      m * 3,
      kernel: 'codex',
      active: true,
    ),
    t(os, 'Boot no ARM', ThreadStatus.idle, m * 60 * 24 * 3, pinned: true),
    t(
      os,
      'Driver de rede antigo',
      ThreadStatus.idle,
      m * 60 * 24 * 40,
      archived: true,
    ),
    t(notes, 'Ideias soltas', ThreadStatus.idle, m * 60 * 8, active: true),
    t(
      notes,
      'Lista de compras',
      ThreadStatus.idle,
      m * 60 * 24 * 14,
      archived: true,
    ),
  ];
}
