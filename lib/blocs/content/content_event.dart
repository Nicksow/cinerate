import 'package:cinerate/models/content.dart';

abstract class ContentEvent {}

class FetchContentEvent extends ContentEvent {}

class ToggleSeenStatus extends ContentEvent {
  final String id;

  ToggleSeenStatus(this.id);
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