import 'package:cinerate/blocs/detail/detail_event.dart';
import 'package:cinerate/blocs/detail/detail_state.dart';
import 'package:cinerate/models/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent,DetailState>{

  DetailBloc() : super(const DetailLoading()){
    on<GetDetailEvent>((event, emit) async {
      try {
        emit(const DetailLoading());
         FirebaseFirestore.instance
            .collection('content')
            .doc(event.id)
            .snapshots()
            .listen((snapshot) {
          final data = snapshot.data();
          final content = Content(
            id: snapshot.id,
            movieId: data!['movieId'],
            title: data['title'],
            opinion: data['opinion'],
            rate: data['rate'],
            type: data['type'],
            date: data['date'].toDate(),
            username: data['user'],
            isSeen: data['isSeen'],
          );
          FirebaseFirestore.instance
              .collection('content')
              .where('movieId', isEqualTo: content.movieId)
              .snapshots()
              .listen((snapshot) {
            final data = snapshot.docs;
            var sum = 0.0;
            double rates = 0.0;
            for (var i = 0; i < data.length; i++) {
              sum += data[i]['rate'];
            }
            rates = sum / data.length;
            this.add(DetailSetState(content: content, rates: rates));
          });
        });
      } catch (e) {
        emit(DetailError("Les données n'ont pas pu être récupérées"));
      }
    });

    on<DetailSetState>((event, emit) {
      emit(DetailState(content: event.content, rates: event.rates));
    });

    on<UpdateNoteEvent>((event, emit) async {
      try {
        await FirebaseFirestore.instance.collection('content').doc(event.id).update({
          'opinion': event.note,
        });
      } catch (e) {
        emit(DetailError("Les données n'ont pas pu être mises à jour"));
      }
    });

    on<UpdateRatingEvent>((event, emit) async {
      try {
        await FirebaseFirestore.instance.collection('content').doc(event.id).update({
          'rate': event.rating,
        });
      } catch (e) {
        emit(DetailError("Les données n'ont pas pu être mises à jour"));
      }
    });

    on<DeleteDetailEvent>((event, emit) async {
      try {
        await FirebaseFirestore.instance.collection('content').doc(event.id).delete();
      } catch (e) {
        emit(DetailError("Les données n'ont pas pu être supprimées"));
      }
    });
  }
}