import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Sub-model for individual Service Checklist items
class ChecklistItemModel {
  final String id;
  final String title;
  bool isDone;

  ChecklistItemModel({
    required this.id,
    required this.title,
    this.isDone = false,
  });
}

/// Sub-model to represent each individual timeline step
class ProgressStepModel {
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool isCurrent;

  ProgressStepModel({
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}

/// Updated Main Appointment Details Model
class AppointmentDetailsModel {
  // Map & Route info
  final String startAddress;
  final String destinationAddress;
  final String distance;
  final String eta;
  final LatLng startLocation;
  final LatLng destinationLocation;

  // Pet & Service details
  final String petName;
  final String clientName;
  final String serviceTitle;

  // Job Progress & Status Tracking
  final String currentStatus;
  final String statusDescription;
  final int currentStep;
  final int totalSteps;
  final String? nextStepTitle;
  final List<ProgressStepModel> progressSteps;

  // Checklist & Completion Info
  final List<ChecklistItemModel> checklistItems;
  String? completionNotes;

  AppointmentDetailsModel({
    required this.startAddress,
    required this.destinationAddress,
    required this.distance,
    required this.eta,
    required this.startLocation,
    required this.destinationLocation,
    required this.petName,
    required this.clientName,
    required this.serviceTitle,
    required this.currentStatus,
    required this.statusDescription,
    required this.currentStep,
    required this.totalSteps,
    this.nextStepTitle,
    required this.progressSteps,
    required this.checklistItems,
    this.completionNotes,
  });

  // Helper Getters for Progress Calculation
  int get completedChecklistCount =>
      checklistItems.where((item) => item.isDone).length;

  int get totalChecklistCount => checklistItems.length;

  double get checklistProgressRatio => totalChecklistCount == 0
      ? 0.0
      : completedChecklistCount / totalChecklistCount;

  int get checklistPercentage => (checklistProgressRatio * 100).toInt();
}
