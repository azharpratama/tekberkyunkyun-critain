class Psychologist {
  final String id;
  final String name;
  final String title; // e.g., "M.Psi., Psikolog"
  final String photoUrl;
  final List<String> specializations;
  final double rating;
  final int reviewCount;
  final int pricePerSession; // in Rupiah
  final String bio;
  final List<String> education;
  final String approach;
  final int yearsOfExperience;

  const Psychologist({
    required this.id,
    required this.name,
    required this.title,
    required this.photoUrl,
    required this.specializations,
    required this.rating,
    required this.reviewCount,
    required this.pricePerSession,
    required this.bio,
    required this.education,
    required this.approach,
    required this.yearsOfExperience,
  });
}
