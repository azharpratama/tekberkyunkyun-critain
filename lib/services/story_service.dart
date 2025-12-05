import '../models/user_story.dart';
import '../data/stories_data.dart';

class StoryService {
  static final StoryService _instance = StoryService._internal();
  factory StoryService() => _instance;
  StoryService._internal();

  // Get all stories
  List<UserStory> getAllStories() {
    return userStories;
  }

  // Get stories by category
  List<UserStory> getStoriesByCategory(String category) {
    if (category == 'All') return userStories;
    return userStories.where((story) => story.category == category).toList();
  }

  // Add new story
  void addStory(UserStory story) {
    userStories.add(story);
  }

  // Generate story ID
  String generateStoryId() {
    if (userStories.isEmpty) return '1';
    final maxId = userStories
        .map((s) => int.tryParse(s.id) ?? 0)
        .reduce((a, b) => a > b ? a : b);
    return (maxId + 1).toString();
  }

  // Calculate read time based on content length
  String calculateReadTime(String content) {
    final wordCount = content.split(RegExp(r'\s+')).length;
    final minutes = (wordCount / 200).ceil(); // Assuming 200 words per minute
    return '$minutes min read';
  }

  // Create excerpt from content
  String createExcerpt(String content, {int maxLength = 150}) {
    if (content.length <= maxLength) return content;
    return '${content.substring(0, maxLength)}...';
  }
}
