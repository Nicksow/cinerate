import 'dart:convert';

import 'package:cinerate/blocs/movieDB/movieDB_event.dart';
import 'package:cinerate/blocs/movieDB/movieDB_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class MovieDBBloc extends Bloc<MovieDBEvent, MovieDBState> {

  final String api_key = 'ed0f4c9c43b58b626a0d64d061d9c7f4';
  final String base_url = 'https://api.themoviedb.org/3/search';

  MovieDBBloc() : super(const MovieDBLoadOut()) {
    on<MovieDBLoadEvent>((event, emit) async {
      try {
        emit(const MovieDBLoading());
        final movieResponse = await _fetchData("movie", event.query);
        final tvResponse = await _fetchData("tv", event.query);
        if (movieResponse.statusCode == 200 && tvResponse.statusCode == 200) {
          final movieData = json.decode(movieResponse.body);
          final tvData = json.decode(tvResponse.body);
          emit(MovieDBLoaded(movieData['results'] + tvData['results']));
        } else {
          emit(const MovieDBError('Erreur lors du chargement des données'));
        }
      } catch (e) {
        emit(const MovieDBError('Erreur lors du chargement des données'));
      }
    });

    on<MovieDBUnloadEvent>((event, emit) {
      emit(const MovieDBLoadOut());
    });
  }

  Future<http.Response> _fetchData(String type, String query) {
    return http.get(Uri.parse('$base_url/$type?api_key=$api_key&query=$query'));
  }
}