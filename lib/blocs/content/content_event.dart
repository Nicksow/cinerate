import 'package:cinerate/models/content.dart';

abstract class ContentEvent {}

class FetchContent extends ContentEvent {}

class ToggleSeenStatus extends ContentEvent {
  final String id;

  ToggleSeenStatus(this.id);
}

class DeleteContent extends ContentEvent {
  final String id;

  DeleteContent(this.id);
}

class UpdateNoteContent extends ContentEvent {
  final String id;
  final String note;

  UpdateNoteContent(this.id, this.note);
}

class AddContent extends ContentEvent {
  final Content content;

  AddContent(this.content);
}