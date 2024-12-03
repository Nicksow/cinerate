import 'package:cinerate/blocs/content/content_event.dart';
import 'package:cinerate/blocs/content/content_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {

  ContentBloc() : super(const ContentLoading()){
    on<AddContentEvent>((event, emit) async {
      FirebaseFirestore.instance.collection('content').add({
        'title': event.content.title,
        'opinion': event.content.opinion,
        'rate': event.content.rate,
        'type': event.content.type,
        'date': event.content.date,
        'user': event.content.username,
        'isSeen': event.content.isSeen,
      });
    });

    on<FetchContentEvent>((event, emit) async {
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

    on<DeleteContentEvent>((event, emit) async {
      try {
        emit(const ContentLoading());
        // final contentList = await _fetchData();
        // emit(ContentLoadSuccess(contentList));
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });

    on<UpdateContentEvent>((event, emit) async {
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