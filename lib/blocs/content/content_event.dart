import 'package:cinerate/models/content.dart';

abstract class ContentEvent {}

class GetContentEvent extends ContentEvent {}

class ToggleSeenStatus extends ContentEvent {
  final String? id;
  final bool isSeen;

  ToggleSeenStatus(this.id,this.isSeen);
}

class ContentSetState extends ContentEvent {
  final List<Content> contentList;

  ContentSetState(this.contentList);
}

class DeleteContentEvent extends ContentEvent {
  final String id;

  DeleteContentEvent(this.id);
}

class UpdateContentEvent extends ContentEvent {
  final String id;
  final String note;

  UpdateContentEvent(this.id, this.note);
}

class AddContentEvent extends ContentEvent {
  final Content content;

  AddContentEvent(this.content);
}
