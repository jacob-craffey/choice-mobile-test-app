import 'package:choice_sample_project/repositories/post_repository.dart';
import 'package:choice_sample_project/widgets/error.dart';
import 'package:choice_sample_project/widgets/loading.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final int id;

  const PostDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late Future<dynamic> _postDataState = PostRepository().getPost(widget.id);

  void refreshList() {
    setState(() {
      _postDataState = PostRepository().getPost(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromARGB(31, 0, 0, 0),
              offset: Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(
            elevation: 0.0,
            title: Text('Post ${widget.id}',
                style: Theme.of(context).textTheme.headline1),
            leading: IconButton(
                icon: const Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight),
      ),
      body: FutureBuilder(
          future: _postDataState,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Container(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(snapshot.data.title,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline2),
                        ),
                        Text(snapshot.data.body,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                    constraints: const BoxConstraints(maxWidth: 800),
                  ),
                ),
                color: Colors.white,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return Error(callback: refreshList);
            }
          }),
    );
  }
}
