class Domain {
  static final Domain _domain = Domain._internal();
  late String serverName;
  late String portNumber;

  factory Domain() {
    _domain.serverName = "192.168.1.4";
    _domain.portNumber = "7072";
    return _domain;
  }
  Domain._internal();
}
