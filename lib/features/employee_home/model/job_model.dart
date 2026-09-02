class JobModel {
  final String id;
  final String petName;
  final String petImageUrl;
  final String serviceTitle;
  final String serviceCategory;
  final String clientName;
  final String time;
  final String duration;
  final double price;
  final String status; // e.g., 'ACCEPTED', 'ASSIGNED'
  final DateTime? date;

  JobModel({
    required this.id,
    required this.petName,
    required this.petImageUrl,
    required this.serviceTitle,
    required this.serviceCategory,
    required this.clientName,
    required this.time,
    required this.duration,
    required this.price,
    required this.status,
    this.date,
  });
}
