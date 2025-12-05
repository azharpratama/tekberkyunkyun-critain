import 'package:flutter/material.dart';
import '../models/faq_item.dart';

class FAQViewModel extends ChangeNotifier {
  final List<FAQItem> _faqs = const [
    FAQItem(
      question: "What is environmental-friendly product?",
      answer:
          "Eco-friendly products are products that contribute to green living or practices that help conserve resources like water and energy.",
    ),
    FAQItem(
      question: "What is the benefit of recycling?",
      answer:
          "Recycling reduces pollution, saves energy, and decreases landfill waste.",
    ),
    FAQItem(
      question: "How can I benefit from recycling?",
      answer:
          "You help the planet, reduce waste, and support sustainability programs.",
    ),
    FAQItem(
      question: "What types of items can be recycled?",
      answer: "Paper, plastic, metal, glass, and certain electronics.",
    ),
  ];

  List<FAQItem> get faqs => _faqs;
}
