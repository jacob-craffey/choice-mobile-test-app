import 'package:choice_sample_project/views/post_detail.dart';
import 'package:flutter/material.dart';
import '../models/post_model.dart';

class Post extends StatelessWidget {
  final PostModel postModel;

  const Post({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Text(postModel.title,
                        style: Theme.of(context).textTheme.headline2),
                  ),
                  Text(postModel.body,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(31, 0, 0, 0),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(16),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetail(
              postModel: postModel,
            ),
          ),
        );
      },
    );
  }
}
