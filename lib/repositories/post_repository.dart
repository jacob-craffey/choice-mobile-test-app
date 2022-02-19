import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostRepository {
  Future getPosts() async {
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

  /// Although I could easily pass the entire object into this widget and
  /// display the post's id, title, and body just fine I'm coding this under
  /// the scenario that we need to fetch additional data for the post detail.
  ///  Thus, the warranted additional api call
  Future getPost(int id) async {
    try {
      var response = await http
          .get(Uri.https('jsonplaceholder.typicode.com', 'posts/$id'));

      var jsonData = jsonDecode(response.body);

      PostModel postModel = PostModel(
          userId: jsonData['userId'],
          id: jsonData['id'],
          title: jsonData['title'],
          body: jsonData['body']);

      return postModel;
    } catch (error) {
      print('error');
    }
  }
}
