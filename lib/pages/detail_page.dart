import 'package:cinerate/blocs/detail/detail_bloc.dart';
import 'package:cinerate/blocs/detail/detail_event.dart';
import 'package:cinerate/blocs/detail/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffF2EFEA)),
        toolbarHeight: 75,
        backgroundColor: const Color(0xff38302E),
        centerTitle: true,
        title: Text('DETAILS',style: TextStyle(fontSize: 26,color: Color(0xffF2EFEA))),
      ),
      body: SingleChildScrollView(child: DetailsContent()),
    );
  }
}

class DetailsContent extends StatefulWidget {
  const DetailsContent({super.key});

  @override
  State<DetailsContent> createState() => _DetailsContent();
}

class _DetailsContent extends State<DetailsContent>{
  final TextEditingController _noteController = TextEditingController();
  double rating = 0.0;
  final detailBloc = DetailBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc,DetailState>(
        builder: (context, state) {
          if(state is DetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
            var content = state.content!;
            var globalRating = state.rates!;
            String formattedDate = DateFormat('dd/MM/yyyy').format(content.date);
            String formattedSeenDate = DateFormat('dd/MM/yyyy').format(content.seenDate);
          _noteController.text = content.opinion;
            rating = content.rate.toDouble();
            return Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Text(content.title,
                              style: const TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )
                        )
                      ]
                  ),
                  const SizedBox(height: 25.0),
                  const Text("Avis personnel",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _noteController,
                      maxLines: 5,
                      onTapOutside: (_) {
                        detailBloc.add(UpdateNoteEvent(content.id, _noteController.text));
                      },
                      decoration: const InputDecoration(
                        border: null,
                        hintText: 'Ajoutez un avis personnel',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Note",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StarRating(
                        size: 30.0,
                        rating: rating,
                        color: Colors.yellow,
                        starCount: 5,
                        allowHalfRating: true,
                        onRatingChanged: (rating) {
                          detailBloc.add(UpdateRatingEvent(content.id,rating));
                          setState(() => this.rating = rating);
                        },
                      ),
                      Padding(padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Global : $globalRating/5",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Text("Ajouté le $formattedDate",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      )
                  ),
                  const SizedBox(height: 10.0),
                  if(content.isSeen)
                    Text("Vu le $formattedSeenDate",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  const SizedBox(height: 150.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Colors.red),
                            minimumSize: WidgetStatePropertyAll(
                                Size(200, 60)),
                          ),
                          onPressed: () {
                            detailBloc.add(DeleteDetailEvent(content.id));
                            Navigator.pop(context);
                          },
                          child: const Text(
                              "Supprimer", style: TextStyle(fontSize: 20,color: Color(0xffF2EFEA)))
                      )
                    ],)
                ],
              ),
            );
        }
    );
  }
}



