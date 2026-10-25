
class NoteModel {
  final String? image;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoteModel({
    this.image,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });
}


List<NoteModel> notes = [
  NoteModel(
    image: 'assets/images/onBoarding_1.png',
    title: 'Meeting Notes',
    content: 'Discuss project milestones and deadlines.',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
  ),
  NoteModel(
    image: 'assets/images/onBoarding_2.png',
    title: 'Grocery List',
    content: 'Milk, Eggs, Bread, Butter, Cheese.',
    createdAt: DateTime.now().subtract(Duration(days: 2)),
  ),
  NoteModel(
    image: 'assets/images/onBoarding_3.png',
    title: 'Workout Plan',
    content: 'Monday MondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMonday',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
  ),
  NoteModel(
    image: 'assets/images/onBoarding_3.png',
    title: 'Workout Plan',
    content: 'Monday: Chest & Triceps\nTuesday: Back & Biceps\nWednesday: Legs & Shoulders',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
  ),
  NoteModel(
    image: 'assets/images/onBoarding_3.png',
    title: 'Workout Plan',
    content: 'Monday: Chest & Triceps\nTuesday: Back & Biceps\nWednesday: Legs & Shoulders',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
  ),
];