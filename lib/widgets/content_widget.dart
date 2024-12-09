import 'package:cinerate/blocs/content/content_bloc.dart';
import 'package:cinerate/blocs/content/content_event.dart';
import 'package:cinerate/blocs/content/content_state.dart';
import 'package:cinerate/blocs/login/login_bloc.dart';
import 'package:cinerate/blocs/login/login_state.dart';
import 'package:cinerate/models/menuIndex.dart';
import 'package:cinerate/widgets/content_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();

}

class _ContentWidgetState extends State<ContentWidget> {
  final contentBloc = ContentBloc();
  @override
  void initState() {
    super.initState();
    contentBloc.add(GetContentEvent());
  }

  @override
  Widget build(BuildContext context) {
    final menuIndex = context.watch<MenuIndex>();

    return BlocProvider.value(
      value: contentBloc,
      child: Expanded(
        child: BlocBuilder<ContentBloc,ContentState>(
          builder: (context, state) {
            var filteredList = state.contentList.where((element) => element.username == (context.read<LoginBloc>().state as LoggedIn).user.name).toList();            var movieToSee = filteredList.where((element) => !element.isSeen && element.type == "Film").toList();
            var movieSeen = filteredList.where((element) => element.isSeen && element.type == "Film").toList();
            var serieToSee = filteredList.where((element) => !element.isSeen && element.type == "Série").toList();
            var serieSeen = filteredList.where((element) => element.isSeen && element.type == "Série").toList();
            if(state is ContentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return TabBarView(
                children: [
                  ListView.builder(
                    itemCount: menuIndex.index == 0 ? movieToSee.length : movieSeen.length,
                    itemBuilder: (context, index) {
                      var data = menuIndex.index == 0 ? movieToSee[index] : movieSeen[index];
                      return ContentTile(data: data);
                    },
                  ),
                  ListView.builder(
                    itemCount: menuIndex.index == 0 ? serieToSee.length : serieSeen.length,
                    itemBuilder: (context, index) {
                      var data = menuIndex.index == 0 ? serieToSee[index] : serieSeen[index];
                      return ContentTile(data: data);
                    },
                  ),
                ],
            );
          },
        ),
      ),
    );
  }
}

