class ViolationReport {
  final String id;
  final String reporterId;
  final String vehicleNumber;
  final String type;
  final String description;
  final String? photoUrl;
  final DateTime createdAt;

  ViolationReport({
    required this.id,
    required this.reporterId,
    required this.vehicleNumber,
    required this.type,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
  });

  factory ViolationReport.fromMap(Map<String, dynamic> map) {
    return ViolationReport(
      id: map['id'],
      reporterId: map['reporter_id'],
      vehicleNumber: map['vehicle_number'],
      type: map['type'],
      description: map['description'],
      photoUrl: map['photo_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
