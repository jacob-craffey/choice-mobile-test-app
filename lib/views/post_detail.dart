import 'package:choice_sample_project/views/post_list.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostDetail extends StatelessWidget {
  final PostModel postModel;

  const PostDetail({Key? key, required this.postModel}) : super(key: key);

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
            title: Text('Post ${postModel.id}',
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(postModel.title,
                  style: Theme.of(context).textTheme.headline2),
            ),
            Text(postModel.body, style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}
