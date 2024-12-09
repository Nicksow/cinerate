import 'package:cinerate/models/content.dart';

class ContentState {
  final List<Content> contentList;

  const ContentState({required this.contentList});
}

class ContentLoading extends ContentState {
  const ContentLoading() : super(contentList: const []);
}

class ContentError extends ContentState {
  final String error;
  const ContentError(this.error) : super(contentList: const []);
}

class ContentLoaded extends ContentState {
  final List<Content> contentList;
  const ContentLoaded(this.contentList) : super(contentList: contentList);
}

