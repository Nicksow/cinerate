import 'package:cinerate/models/content.dart';

class DetailState {
  final Content? content;
  final double? rates;
  const DetailState({required this.content, required this.rates});
}

class DetailLoading extends DetailState {
  const DetailLoading() : super(content: null, rates: null);
}

class DetailError extends DetailState {
  final String error;
  const DetailError(this.error) : super(content: null, rates: null);
}

class DetailLoaded extends DetailState {
  final Content content;
  const DetailLoaded(this.content) : super(content: content, rates: null);
}
