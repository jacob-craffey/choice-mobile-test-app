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

  void retryGetPosts() {
    setState(() {
      _postsDataState = PostRepository().getPosts();
    });
  }

  Future<void> refreshGetPosts(BuildContext context) {
    retryGetPosts();
    return _postsDataState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onPrimary,
              offset: const Offset(0, 2.0),
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
      body: RefreshIndicator(
        onRefresh: () => refreshGetPosts(context),
        child: FutureBuilder(
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Center(
                        child: Container(
                            child: Post(postModel: snapshot.data[i]),
                            constraints: const BoxConstraints(maxWidth: 600)),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return Error(callback: retryGetPosts);
            }
          },
        ),
      ),
    );
  }
}
