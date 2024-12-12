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
      context.read<ContentBloc>().add(ToggleSeenStatus(widget.data.id, widget.data.isSeen));
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
          child: ListTile(
            textColor: Colors.white,
            tileColor: const Color(0xFF788585),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: Text(
                widget.data.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                )
            ),
            subtitle: Text(widget.data.opinion,
                overflow: TextOverflow.ellipsis
            ),
            onTap: () async {
              context.read<DetailBloc>().add(GetDetailEvent(widget.data.id));
              Navigator.pushNamed(context, '/detail');
            },
            trailing: Container(
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
          ),
        ),
      ),
    );
  }
}
