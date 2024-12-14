import 'dart:async';

import 'package:cinerate/blocs/content/content_event.dart';
import 'package:cinerate/blocs/content/content_state.dart';
import 'package:cinerate/models/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  ContentBloc() : super(const ContentLoading()){
    on<AddContentEvent>((event, emit) async {
      FirebaseFirestore.instance.collection('content').add({
        'imageUrl': event.content.imageUrl,
        'movieId': event.content.movieId,
        'title': event.content.title,
        'opinion': event.content.opinion,
        'rate': event.content.rate,
        'type': event.content.type,
        'date': event.content.date,
        'user': event.content.username,
        'isSeen': event.content.isSeen,
      });
    });

    on<ContentSetState>((event, emit) {
      emit(ContentState(contentList: event.contentList));
    });

    on<GetContentEvent>((event, emit) async {
      try {
        emit(const ContentLoading());
        if (_subscription != null) {
          _subscription!.cancel();
        }
        _subscription = FirebaseFirestore.instance
            .collection('content')
            .orderBy('date', descending: false)
            .snapshots()
            .listen((snapshot) {
          final contentList = snapshot.docs.map((doc) {
            final data = doc.data();
            return Content(
              id: doc.id,
              imageUrl: data['imageUrl'],
              title: data['title'],
              opinion: data['opinion'],
              rate: data['rate'],
              type: data['type'],
              date: data['date'].toDate(),
              username: data['user'],
              isSeen: data['isSeen'],
            );
          }).toList();
          this.add(ContentSetState(contentList));
        });
      } catch (e) {
        emit(ContentError("Les données n'ont pas pu être récupérées"));
      }
    });

    on<ToggleSeenStatus>((event, emit) async {
      try {
        emit(const ContentLoading());
        if (_subscription != null) {
          _subscription!.cancel();
        }
        if (event.isSeen) {
          FirebaseFirestore.instance.collection('content').doc(event.id).update({
            'isSeen': false,
          });
        } else {
          FirebaseFirestore.instance.collection('content').doc(event.id).update({
            'isSeen': true,
          });
        }
        this.add(GetContentEvent());
      } catch (e) {
        emit(ContentError(e.toString()));
      }
    });
  }
}