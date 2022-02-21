import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostRepository {
  Future getPosts() async {
    try {
      var response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));

      dynamic rawPostsData = jsonDecode(response.body);
      List<PostModel> posts = [];

      for (dynamic rawPost in rawPostsData) {
        posts.add(mapPostData(rawPost));
      }
      return posts;
    } catch (error) {
      throw Exception('Failed to get Posts');
    }
  }

  Future getPost(int id) async {
    try {
      var response = await http
          .get(Uri.https('jsonplaceholder.typicode.com', 'posts/$id'));

      var jsonData = jsonDecode(response.body);
      PostModel postModel = mapPostData(jsonData);

      return postModel;
    } catch (error) {
      throw Exception('Failed to get Post $id');
    }
  }

  PostModel mapPostData(dynamic rawPost) {
    try {
      PostModel postModel = PostModel(
          userId: rawPost['userId'],
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body']);
      return postModel;
    } catch (error) {
      throw Exception('Failed to map Post JSON data');
    }
  }
}
