import 'package:cinerate/models/content.dart';

abstract class ContentState {
  const ContentState();
}

class ContentLoading extends ContentState {
  const ContentLoading();
}

class ContentError extends ContentState {
  final String error;

  ContentError(this.error);
}

class ContentLoaded extends ContentState {
  final List<Content> contentList;

  ContentLoaded(this.contentList);
}
