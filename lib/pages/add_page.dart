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
        title: const Center(
          child: Text('AJOUT FILMS / SERIES', style: TextStyle(fontSize: 26, color: Color(0xffF2EFEA))),
        ),
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
          _buildTitle("Titre"),
          _buildSearchBar(movieDBBloc),
          _buildMovieDBList(movieDBBloc),
          const SizedBox(height: 20.0),
          _buildTitle("Avis personnel"),
          _buildOpinionField(),
          const SizedBox(height: 20.0),
          _buildTitle("Note"),
          _buildRatingBar(),
          const SizedBox(height: 20.0),
          _buildRadioListTile("Film"),
          _buildRadioListTile("Série"),
          _buildAddButton(contentBloc, loginBloc),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 24, color: Colors.white));
  }

  Widget _buildSearchBar(MovieDBBloc movieDBBloc) {
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

  Widget _buildMovieDBList(MovieDBBloc movieDBBloc) {
    return BlocBuilder<MovieDBBloc, MovieDBState>(
      builder: (context, state) {
        if (state is MovieDBLoaded && state.content.isNotEmpty) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.content.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.content[index]['title'] ?? state.content[index]['name'], style: const TextStyle(color: Color(0xffF2EFEA))),
                  onTap: () {
                    _textFieldController.text = state.content[index]['title'] ?? state.content[index]['name'];
                    setState(() {
                      currentOption = state.content[index]['type'];
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

  Widget _buildOpinionField() {
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

  Widget _buildRatingBar() {
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

  Widget _buildRadioListTile(String value) {
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

  Widget _buildAddButton(ContentBloc contentBloc, LoginBloc loginBloc) {
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
              title: _textFieldController.text,
              opinion: _opinionController.text,
              rate: rating,
              type: currentOption,
              date: DateTime.now(),
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

