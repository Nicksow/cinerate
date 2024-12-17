import 'package:cinerate/blocs/content/content_bloc.dart';
import 'package:cinerate/blocs/content/content_event.dart';
import 'package:cinerate/blocs/login/login_bloc.dart';
import 'package:cinerate/blocs/login/login_state.dart';
import 'package:cinerate/blocs/movieDB/movieDB_bloc.dart';
import 'package:cinerate/blocs/movieDB/movieDB_event.dart';
import 'package:cinerate/blocs/movieDB/movieDB_state.dart';
import 'package:cinerate/models/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffF2EFEA)),
        toolbarHeight: 75,
        backgroundColor: const Color(0xff38302E),
        centerTitle: true,
        title: Text('AJOUT FILMS / SERIES', style: TextStyle(fontSize: 26, color: Color(0xffF2EFEA))),
      ),
      body: const SingleChildScrollView(child: DataPage()),
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

const List<String> contentType = ["Film", "Série"];
class _DataPageState extends State<DataPage> {
  final _textFieldController = TextEditingController();
  final _opinionController = TextEditingController();
  String currentOption = contentType[0];
  double rating = 0.0;
  String imageUrl = '';
  var movieId = 0;

  @override
  Widget build(BuildContext context) {
    var movieDBBloc = context.read<MovieDBBloc>();
    var loginBloc = context.read<LoginBloc>();
    var contentBloc = context.read<ContentBloc>();

    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          myTitle("Titre"),
          mySearchBar(movieDBBloc),
          myMovieDBList(movieDBBloc),
          const SizedBox(height: 20.0),
          myTitle("Avis personnel"),
          myOpinionField(),
          const SizedBox(height: 20.0),
          myTitle("Note"),
          myRatingBar(),
          const SizedBox(height: 20.0),
          myRadioListTile("Film"),
          myRadioListTile("Série"),
          myAddButton(contentBloc, loginBloc),
        ],
      ),
    );
  }

  Widget myTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 24, color: Colors.white));
  }

  Widget mySearchBar(MovieDBBloc movieDBBloc) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: _textFieldController,
            hintText: 'Rechercher un film ou une série',
            leading: const Icon(Icons.search),
            onChanged: (value) {
              movieDBBloc.add(MovieDBLoadEvent(query: value));
            },
          ),
        ),
      ],
    );
  }

  Widget myMovieDBList(MovieDBBloc movieDBBloc) {
    return BlocBuilder<MovieDBBloc, MovieDBState>(
      builder: (context, state) {
        if (state is MovieDBLoaded && state.content.isNotEmpty) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.content.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://image.tmdb.org/t/p/w500${state.content[index]['poster_path']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 18,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.content[index]['title'] ?? state.content[index]['name'], style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis)),
                                  Text(state.content[index]['overview'], style: const TextStyle(overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _textFieldController.text = state.content[index]['title'] ?? state.content[index]['name'];
                    setState(() {
                      imageUrl = state.content[index]['poster_path'];
                      currentOption = state.content[index]['type'];
                      movieId = state.content[index]['id'];
                    });
                    movieDBBloc.add(MovieDBUnloadEvent());
                  },
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget myOpinionField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _opinionController,
        maxLines: 5,
        decoration: const InputDecoration(
          border: null,
          hintText: 'Ajoutez un avis personnel',
        ),
      ),
    );
  }

  Widget myRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StarRating(
          size: 30.0,
          rating: rating,
          color: Colors.yellow,
          starCount: 5,
          allowHalfRating: true,
          onRatingChanged: (rating) => setState(() => this.rating = rating),
        ),
      ],
    );
  }

  Widget myRadioListTile(String value) {
    return RadioListTile(
      fillColor: WidgetStateProperty.all(Colors.white),
      title: Text(value, style: const TextStyle(color: Color(0xffF2EFEA))),
      value: value,
      groupValue: currentOption,
      onChanged: (value) {
        setState(() {
          currentOption = value.toString();
        });
      },
    );
  }

  Widget myAddButton(ContentBloc contentBloc, LoginBloc loginBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: const ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(200, 60)),
            backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
          ),
          onPressed: () {
            contentBloc.add(AddContentEvent(Content(
              imageUrl: imageUrl,
              movieId: movieId,
              title: _textFieldController.text,
              opinion: _opinionController.text,
              rate: rating,
              type: currentOption,
              date: DateTime.now(),
              seenDate: DateTime.now(),
              username: (loginBloc.state as LoggedIn).user.name,
              isSeen: false,
            )));
            Navigator.pop(context);
          },
          child: const Text("Ajouter", style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ],
    );
  }
}

