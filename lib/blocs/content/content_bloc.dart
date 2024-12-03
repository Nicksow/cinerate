import 'package:cinerate/blocs/content/content_event.dart';
import 'package:cinerate/blocs/content/content_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {

  ContentBloc() : super(const ContentLoading()){
    on<FetchContent>((event, emit) async {
      try {
        emit(const ContentLoading());
        // final contentList = await _fetchData();
        // emit(ContentLoadSuccess(contentList));
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });

    on<ToggleSeenStatus>((event, emit) async {
      try {
        emit(const ContentLoading());
        // final contentList = await _fetchData();
        // emit(ContentLoadSuccess(contentList));
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });

    on<DeleteContent>((event, emit) async {
      try {
        emit(const ContentLoading());
        // final contentList = await _fetchData();
        // emit(ContentLoadSuccess(contentList));
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });

    on<UpdateNoteContent>((event, emit) async {
      try {
        emit(const ContentLoading());
        // final contentList = await _fetchData();
        // emit(ContentLoadSuccess(contentList));
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });

    on<AddContent>((event, emit) async {
      try {
        emit(const ContentLoading());
        // final contentList = await _fetchData();
        // emit(ContentLoadSuccess(contentList));
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });
  }
}