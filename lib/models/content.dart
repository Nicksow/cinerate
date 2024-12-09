class Content {
  final String? id;
  final String title;
  final String opinion;
  final double rate;
  final String type;
  final bool isSeen;
  final String username;
  final DateTime date;

  Content({this.id,required this.title, required this.opinion, required this.rate, required this.type, required this.date, required this.username, required this.isSeen});
}