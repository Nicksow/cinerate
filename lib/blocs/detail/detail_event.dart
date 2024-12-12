import 'package:cinerate/models/content.dart';

abstract class DetailEvent {}

class GetDetailEvent extends DetailEvent {
  final String? id;
  GetDetailEvent(this.id);
}


class UpdateNoteEvent extends DetailEvent {
  final String? id;
  final String note;

  UpdateNoteEvent(this.id, this.note);
}

class UpdateRatingEvent extends DetailEvent {
  final String? id;
  final double rating;

  UpdateRatingEvent(this.id, this.rating);
}

class DeleteDetailEvent extends DetailEvent {
  final String? id;

  DeleteDetailEvent(this.id);
}

class DetailSetState extends DetailEvent {
  final Content content;
  final double? rates;
  DetailSetState({required this.content, this.rates});
}