import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../widgets/post.dart';
import 'package:http/http.dart' as http;

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Future getPostData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));

    var jsonData = jsonDecode(response.body);
    List<PostModel> posts = [];

    for (var u in jsonData) {
      PostModel postModel = PostModel(
          userId: u['userId'], id: u['id'], title: u['title'], body: u['body']);
      posts.add(postModel);
    }

    return posts;
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
      body: Card(
        child: FutureBuilder(
          future: getPostData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 05, 0, 255)),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Post(postModel: snapshot.data[i]),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
