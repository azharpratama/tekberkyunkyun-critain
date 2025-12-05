import '../models/psychologist.dart';

final List<Psychologist> mockPsychologists = [
  Psychologist(
    id: '1',
    name: 'Dr. Sarah Wijaya',
    title: 'M.Psi., Psikolog Klinis',
    photoUrl:
        'https://ui-avatars.com/api/?name=Sarah+Wijaya&background=4A90E2&color=fff&size=200',
    specializations: ['Anxiety', 'Depression', 'Stress Management'],
    rating: 4.9,
    reviewCount: 142,
    pricePerSession: 99000,
    bio:
        'Psikolog klinis dengan pengalaman 8+ tahun membantu individu mengatasi kecemasan, depresi, dan stres. Pendekatan saya berfokus pada cognitive behavioral therapy (CBT) dan mindfulness.',
    education: [
      'S1 Psikologi - Universitas Indonesia',
      'S2 Psikologi Klinis - Universitas Gadjah Mada',
      'Certified CBT Therapist',
    ],
    approach:
        'Cognitive Behavioral Therapy (CBT), Mindfulness-Based Stress Reduction',
    yearsOfExperience: 8,
  ),
  Psychologist(
    id: '2',
    name: 'Dr. Budi Santoso',
    title: 'M.Psi., Psikolog',
    photoUrl:
        'https://ui-avatars.com/api/?name=Budi+Santoso&background=3A9D76&color=fff&size=200',
    specializations: ['Career Counseling', 'Work-Life Balance', 'Burnout'],
    rating: 4.7,
    reviewCount: 98,
    pricePerSession: 99000,
    bio:
        'Spesialis dalam konseling karir dan manajemen stres kerja. Membantu profesional muda menemukan keseimbangan dan mengatasi burnout dengan pendekatan holistik.',
    education: [
      'S1 Psikologi - Universitas Airlangga',
      'S2 Psikologi Industri & Organisasi - UI',
    ],
    approach: 'Solution-Focused Brief Therapy, Positive Psychology',
    yearsOfExperience: 6,
  ),
  Psychologist(
    id: '3',
    name: 'Dr. Rina Kusuma',
    title: 'M.Psi., Psikolog Klinis',
    photoUrl:
        'https://ui-avatars.com/api/?name=Rina+Kusuma&background=E57373&color=fff&size=200',
    specializations: ['Relationship Issues', 'Self-esteem', 'Trauma'],
    rating: 4.8,
    reviewCount: 127,
    pricePerSession: 99000,
    bio:
        'Membantu individu membangun hubungan yang sehat dan mengatasi trauma masa lalu. Pendekatan saya menggabungkan terapi naratif dan EMDR untuk penyembuhan holistik.',
    education: [
      'S1 Psikologi - Universitas Padjajaran',
      'S2 Psikologi Klinis - Universitas Indonesia',
      'EMDR Certified Therapist',
    ],
    approach:
        'Narrative Therapy, EMDR (Eye Movement Desensitization and Reprocessing)',
    yearsOfExperience: 10,
  ),
  Psychologist(
    id: '4',
    name: 'Dr. Ahmad Rizki',
    title: 'M.Psi., Psikolog',
    photoUrl:
        'https://ui-avatars.com/api/?name=Ahmad+Rizki&background=9C27B0&color=fff&size=200',
    specializations: ['Young Adults', 'Academic Stress', 'Identity Crisis'],
    rating: 4.6,
    reviewCount: 84,
    pricePerSession: 99000,
    bio:
        'Spesialis dalam isu-isu remaja dan dewasa muda. Memahami tekanan akademik dan pencarian identitas di era modern. Menciptakan ruang aman untuk eksplorasi diri.',
    education: [
      'S1 Psikologi - Universitas Brawijaya',
      'S2 Psikologi Perkembangan - UGM',
    ],
    approach:
        'Person-Centered Therapy, Acceptance and Commitment Therapy (ACT)',
    yearsOfExperience: 5,
  ),
  Psychologist(
    id: '5',
    name: 'Dr. Maya Sari',
    title: 'M.Psi., Psikolog Klinis',
    photoUrl:
        'https://ui-avatars.com/api/?name=Maya+Sari&background=FF9800&color=fff&size=200',
    specializations: ['PTSD', 'Grief & Loss', 'Emotional Regulation'],
    rating: 4.9,
    reviewCount: 156,
    pricePerSession: 99000,
    bio:
        'Berpengalaman dalam menangani trauma kompleks, kehilangan, dan gangguan emosional. Menggunakan pendekatan trauma-informed care untuk membantu klien membangun ketahanan.',
    education: [
      'S1 Psikologi - Universitas Indonesia',
      'S2 Psikologi Klinis - UI',
      'Trauma-Informed Care Specialist',
    ],
    approach: 'Trauma-Informed Care, Emotion-Focused Therapy',
    yearsOfExperience: 12,
  ),
];
