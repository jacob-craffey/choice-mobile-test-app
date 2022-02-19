import 'package:choice_sample_project/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:choice_sample_project/widgets/error.dart';
import '../widgets/loading.dart';
import '../widgets/post.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final ScrollController _scrollController = ScrollController();
  late Future<dynamic> _postsDataState = PostRepository().getPosts();

  void refreshList() {
    setState(() {
      _postsDataState = PostRepository().getPosts();
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
            title: Text('Posts', style: Theme.of(context).textTheme.headline1),
          ),
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight),
      ),
      body: FutureBuilder(
        future: _postsDataState,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Scrollbar(
              controller: _scrollController,
              thickness: 8,
              radius: const Radius.circular(10),
              interactive: true,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Post(postModel: snapshot.data[i]),
                  );
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            return Error(callback: refreshList);
          }
        },
      ),
    );
  }
}
