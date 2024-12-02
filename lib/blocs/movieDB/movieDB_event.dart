abstract class MovieDBEvent {}

class MovieDBLoadEvent extends MovieDBEvent {
  final String query;

  MovieDBLoadEvent({required this.query});
}

class MovieDBUnloadEvent extends MovieDBEvent {}
