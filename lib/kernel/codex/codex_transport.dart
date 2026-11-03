/// Codex's side of the adapter (the Adaptee): JSON-RPC 2.0 with
/// `codex app-server` over stdio, one message per line.
abstract interface class CodexTransport {
  /// Responses (`id` + `result`), notifications (`method` + `params`) and
  /// server requests (`id` + `method` + `params`, e.g. approvals).
  Stream<Map<String, Object?>> get messages;

  /// Writes a request, or the response to a server request.
  void write(Map<String, Object?> message);

  void close();
}

/// Not Codex's own: what a transport says, as a notification, when the
/// server ended or could not start (`params`: `message`, `detail`).
const codexExited = 'baocode/exited';
