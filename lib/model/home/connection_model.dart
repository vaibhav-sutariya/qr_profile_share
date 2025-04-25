class ConnectionModel {
  final String name;
  final String role;
  final String imageUrl;
  final String time;
  final bool isOnline;

  ConnectionModel({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.time,
    this.isOnline = false,
  });
}
