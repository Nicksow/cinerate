import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';


class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xffF2EFEA),
        ),
        toolbarHeight: 75,
        backgroundColor: const Color(0xff38302E),
        title: const Center(
            child: Text('AJOUT FILMS / SERIES',
                style: TextStyle(
                  fontSize: 26,
                  color: Color(0xffF2EFEA),
                ))
        ),
      ),
      body: const SingleChildScrollView(child: DataPage())
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPage();
}
List<String> contentType = ["Film", "Série"];

class _DataPage extends State<DataPage> {
final _textFieldController = TextEditingController();
final _opinionController = TextEditingController();
String currentOption = contentType[0];
double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Titre",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              )
          ),
          SearchBar(
            hintText: "Rechercher un film ou une série",
            controller: _textFieldController,
            leading: const Icon(Icons.search),
          ),
          const SizedBox(height: 20.0),
          const Text("Avis personnel",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              )
          ),
          Container(
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
                onRatingChanged: (rating) => setState(() => this.rating = rating),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          RadioListTile(
              title: const Text("Film", style: TextStyle(color: Color(0xffF2EFEA))),
              value: contentType[0],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
          ),
          RadioListTile(
              title: const Text("Série", style: TextStyle(color: Color(0xffF2EFEA))),
              value: contentType[1],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(200, 60)),
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                  ),
                  onPressed: () {
                    sendVisualContent();
                  },
                  child: const Text("Ajouter",style: TextStyle(fontSize: 20, color: Colors.white))
              )
            ],)
        ],
      ),
    );
  }

  void sendVisualContent() {}
}