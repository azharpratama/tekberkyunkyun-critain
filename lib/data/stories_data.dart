import '../models/user_story.dart';

const List<UserStory> userStories = [
  UserStory(
    id: '1',
    title: 'Mengenal Anxiety: Lebih dari Sekadar Rasa Cemas',
    excerpt:
        'Kecemasan adalah hal yang wajar, namun ketika ia mulai mengganggu aktivitas sehari-hari, mungkin itu tanda anxiety disorder.',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    authorName: 'Dr. Sarah Johnson',
    authorAvatar: 'assets/avatars/dr_sarah.png', // Placeholder
    date: '20 Okt 2023',
    coverImage: 'assets/images/anxiety_cover.png', // Placeholder
    category: 'Kesehatan Mental',
    readTime: '5 min read',
    likesCount: 124,
    commentsCount: 45,
    isLiked: true,
  ),
  UserStory(
    id: '2',
    title: 'Surviving the Darkest Night',
    excerpt:
        'Sebuah cerita pribadi tentang bagaimana saya melewati masa depresi berat dan menemukan cahaya kembali.',
    content:
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    authorName: 'Alex Nugraha',
    authorAvatar: 'assets/avatars/alex.png',
    date: '18 Okt 2023',
    coverImage: 'assets/images/dark_night.png',
    category: 'Personal Story',
    readTime: '8 min read',
    likesCount: 89,
    commentsCount: 22,
    isBookmarked: true,
  ),
  UserStory(
    id: '3',
    title: 'Tips Meditasi untuk Pemula',
    excerpt:
        'Panduan singkat memulai meditasi mindfulness untuk mengurangi stres dan meningkatkan fokus.',
    content:
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    authorName: 'Mindful Maya',
    authorAvatar: 'assets/avatars/maya.png',
    date: '15 Okt 2023',
    coverImage: null, // Test no image
    category: 'Wellness',
    readTime: '3 min read',
    likesCount: 256,
    commentsCount: 12,
  ),
  UserStory(
    id: '4',
    title: 'My Journey with Bipolar Disorder',
    excerpt:
        'Living with bipolar is a rollercoaster. Here is how I manage my highs and lows.',
    content:
        'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
    authorName: 'Rendi Pratama',
    authorAvatar: 'assets/avatars/rendi.png',
    date: '10 Okt 2023',
    coverImage: 'assets/images/bipolar.png',
    category: 'Personal Story',
    readTime: '6 min read',
    likesCount: 67,
    commentsCount: 8,
  ),
  UserStory(
    id: '5',
    title: 'Burnout vs Stress: What is the Difference?',
    excerpt:
        'Understanding the key differences between burnout and stress can help you seek the right support.',
    content:
        'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.',
    authorName: 'Work Life Balance',
    authorAvatar: 'assets/avatars/work.png',
    date: '05 Okt 2023',
    coverImage: 'assets/images/burnout.png',
    category: 'Work',
    readTime: '4 min read',
    likesCount: 156,
    commentsCount: 30,
  ),
];
