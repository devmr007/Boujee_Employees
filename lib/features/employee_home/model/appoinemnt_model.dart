class AppointmentModel {
  final String serviceTitle;
  final String petName;
  final String clientName;
  final String serviceCategory;
  final double price;
  final String time;
  final String duration;
  final String eta;

  AppointmentModel({
    required this.serviceTitle,
    required this.petName,
    required this.clientName,
    required this.serviceCategory,
    required this.price,
    required this.time,
    required this.duration,
    required this.eta,
  });
}
