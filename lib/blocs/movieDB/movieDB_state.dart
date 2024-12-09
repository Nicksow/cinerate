abstract class MovieDBState {
  const MovieDBState();
}

class MovieDBLoading extends MovieDBState {
  const MovieDBLoading();
}

class MovieDBError extends MovieDBState {
  final String error;

  const MovieDBError(this.error);
}

class MovieDBLoaded extends MovieDBState {
  final List<dynamic> content;

  const MovieDBLoaded(this.content);
}

class MovieDBLoadOut extends MovieDBState {
  const MovieDBLoadOut();
}

