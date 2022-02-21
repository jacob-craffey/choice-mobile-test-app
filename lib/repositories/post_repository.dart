import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostRepository {
  Future getPosts() async {
    try {
      var response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));

      dynamic jsonData = jsonDecode(response.body);
      List<PostModel> posts = [];

      for (dynamic rawPost in jsonData) {
        posts.add(PostModel.fromJson(rawPost));
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
      PostModel postModel = PostModel.fromJson(jsonData);

      return postModel;
    } catch (error) {
      throw Exception('Failed to get Post $id');
    }
  }
}
