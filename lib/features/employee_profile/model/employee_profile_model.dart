class EmployeeProfileModel {
  final String avatarUrl;
  final String name;
  final String email;
  final String badge;
  final double rating;
  final int jobsDone;
  final String role;
  final String employeeId;
  final String startDate;
  final String experience;
  final String workingHours;
  final List<CertificationModel> certifications;

  EmployeeProfileModel({
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.badge,
    required this.rating,
    required this.jobsDone,
    required this.role,
    required this.employeeId,
    required this.startDate,
    required this.experience,
    required this.workingHours,
    required this.certifications,
  });

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileModel(
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      badge: json['badge'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      jobsDone: json['jobs_done'] ?? 0,
      role: json['role'] ?? '',
      employeeId: json['employee_id'] ?? '',
      startDate: json['start_date'] ?? '',
      experience: json['experience'] ?? '',
      workingHours: json['working_hours'] ?? '',
      certifications:
          (json['certifications'] as List<dynamic>?)
              ?.map((item) => CertificationModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar_url': avatarUrl,
      'name': name,
      'email': email,
      'badge': badge,
      'rating': rating,
      'jobs_done': jobsDone,
      'role': role,
      'employee_id': employeeId,
      'start_date': startDate,
      'experience': experience,
      'working_hours': workingHours,
      'certifications': certifications.map((e) => e.toJson()).toList(),
    };
  }
}

class CertificationModel {
  final String title;
  final String icon;

  CertificationModel({required this.title, this.icon = '🏅'});

  factory CertificationModel.fromJson(Map<String, dynamic> json) {
    return CertificationModel(
      title: json['title'] ?? '',
      icon: json['icon'] ?? '🏅',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'icon': icon};
  }
}
