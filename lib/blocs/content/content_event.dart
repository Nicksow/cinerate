import 'package:cinerate/models/content.dart';

abstract class ContentEvent {}

class GetContentEvent extends ContentEvent {}

class AddContentEvent extends ContentEvent {
  final Content content;

  AddContentEvent(this.content);
}

class ToggleSeenStatus extends ContentEvent {
  final String? id;
  final bool isSeen;

  ToggleSeenStatus(this.id,this.isSeen);
}

class ContentSetState extends ContentEvent {
  final List<Content> contentList;

  ContentSetState(this.contentList);
}

