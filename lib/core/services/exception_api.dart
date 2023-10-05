class ExceptionApi implements Exception {
  String msg;

  ExceptionApi(this.msg);

  @override
  String toString() {
    return "Errore: $msg";
  }
}
