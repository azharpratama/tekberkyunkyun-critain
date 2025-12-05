import 'package:flutter/material.dart';
import '../data/psychologist_data.dart';
import '../models/psychologist.dart';

class ConsultationViewModel extends ChangeNotifier {
  // Psychologist Data
  List<Psychologist> get psychologists => mockPsychologists;

  // Filter Logic (Future)
  // void filterBySpecialization(String spec) { ... }
}
