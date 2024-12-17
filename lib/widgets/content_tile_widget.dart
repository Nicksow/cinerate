import 'package:cinerate/blocs/content/content_bloc.dart';
import 'package:cinerate/blocs/content/content_event.dart';
import 'package:cinerate/blocs/detail/detail_bloc.dart';
import 'package:cinerate/blocs/detail/detail_event.dart';
import 'package:cinerate/models/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentTile extends StatefulWidget {
  const ContentTile({
    super.key,
    required this.data,
  });

  final Content data;

  @override
  State<ContentTile> createState() => _ContentTileState();
}

class _ContentTileState extends State<ContentTile> {
  double opacity = 1.0;

  void toggleSeenAnimation(BuildContext context) {
    setState(() {
      opacity = opacity == 1.0 ? 0.5 : 1.0;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      var contentBloc = context.read<ContentBloc>();
      contentBloc.add(ToggleSeenStatus(widget.data.id, widget.data.isSeen));
      if (widget.data.isSeen) {
        contentBloc.add(UpdateSeenDate(widget.data.id, DateTime.now()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Opacity(
          opacity: widget.data.isSeen ? 0.5 : 1,
          child: GestureDetector(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: const Color(0xFF788585),
                height: 80,
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500${widget.data.imageUrl}' ?? 'https://via.placeholder.com/150'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.data.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              widget.data.opinion,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: widget.data.isSeen ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: const Icon( IconData(0xe156, fontFamily: 'MaterialIcons'),),
                        color: Colors.black,
                        onPressed: () {
                          toggleSeenAnimation(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              context.read<DetailBloc>().add(GetDetailEvent(widget.data.id));
              Navigator.pushNamed(context, '/detail');
            },
          ),
        ),
      ),
    );
  }
}
