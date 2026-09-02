import 'package:boujee_employees/core/utils/constants/app_colors.dart';
import 'package:boujee_employees/features/employee_home/presentation/screen/appointment_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Static version of Job Details screen — all data is hardcoded
/// so it can run standalone without any model/backend wiring.
/// Replace the constants below with real data later.

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  // ---- Static data ----
  static const String petImageUrl =
      'https://images.unsplash.com/photo-1552053831-71594a27632d?w=800';
  static const String petName = 'Truffle';
  static const String status = 'ACCEPTED';
  static const String ownerName = 'Robert Cary';
  static const String ownerLocation = 'Golden Avenue 0530 Preston Rd, Ingl...';
  static const String ownerAvatarUrl =
      'https://randomuser.me/api/portraits/men/32.jpg';
  static const String time = '9:00 AM';
  static const String duration = '90 min';
  static const String serviceName = 'Grooming pkg 20-40lbs';
  static const String category = 'Dog Royal Services';
  static const String travelTime = '12 min (4.2 mi)';
  static const String customerNotes =
      'Biscuit loves treats. Please use the lavender shampoo only.';

  static final List<_ReviewData> _reviews = [
    _ReviewData(
      reviewerName: 'Alex Rivera',
      avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
      rating: 5.0,
      date: '25 Jan',
      comment: 'Great session! Biscuit was very well-behaved throughout.',
    ),
    _ReviewData(
      reviewerName: 'Maria Lopez',
      avatarUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
      rating: 5.0,
      date: '25 Jan',
      comment: 'Slightly anxious at the start but settled down quickly.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    _buildImage(),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleRow(),
                          const SizedBox(height: 4),
                          const Text(
                            '$ownerName · 1yr',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.greyText,
                            ),
                          ),
                          const Text(
                            '$time · $duration',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.greyText,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildOwnerCard(),
                          const SizedBox(height: 16),
                          _buildServiceDetailsCard(),
                          const SizedBox(height: 16),
                          _buildCustomerNotesCard(),
                          const SizedBox(height: 20),
                          _buildReviewsHeader(),
                          const SizedBox(height: 12),
                          ..._reviews.map(
                            (r) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: _buildReviewTile(r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const Expanded(
            child: Text(
              'Job Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Image.network(
            petImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.cardBg,
              alignment: Alignment.center,
              child: const Icon(
                Icons.pets,
                size: 48,
                color: AppColors.greyText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          petName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        const Text(
          status,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.accentOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8DBDF), width: 1),
      ),
      child: child,
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.greyText,
      ),
    );
  }

  Widget _buildOwnerCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Pet Owner'),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildNetworkAvatar(url: ownerAvatarUrl, radius: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ownerName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText,
                      ),
                    ),
                    const Text(
                      ownerLocation,
                      style: TextStyle(fontSize: 12, color: AppColors.greyText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text('Call Client'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkText,
                    side: const BorderSide(color: AppColors.darkText),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.navigation_outlined, size: 18),
                  label: const Text('Navigate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF1F5F9),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.greyText),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Service Details'),
          const SizedBox(height: 8),
          _buildDetailRow('Service', serviceName),
          _buildDetailRow('Category', category),
          _buildDetailRow('Time', time),
          _buildDetailRow('Duration', duration),
          _buildDetailRow('Travel', travelTime),
        ],
      ),
    );
  }

  Widget _buildCustomerNotesCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Customer Notes'),
          const SizedBox(height: 10),
          const Text(
            customerNotes,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.darkText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'View All',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.accentOrange,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewTile(_ReviewData review) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNetworkAvatar(url: review.avatarUrl, radius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.reviewerName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText,
                      ),
                    ),
                    Text(
                      review.date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.greyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: AppColors.accentOrange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.greyText,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkAvatar({required String url, required double radius}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.cardBg,
      child: ClipOval(
        child: Image.network(
          url,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              Icon(Icons.person, size: radius, color: AppColors.greyText),
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            Get.to(const AppointmentStatusScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentOrange,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Manage Job Status',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _ReviewData {
  final String reviewerName;
  final String avatarUrl;
  final double rating;
  final String date;
  final String comment;

  const _ReviewData({
    required this.reviewerName,
    required this.avatarUrl,
    required this.rating,
    required this.date,
    required this.comment,
  });
}
