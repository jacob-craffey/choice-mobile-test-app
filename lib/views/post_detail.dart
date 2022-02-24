import 'package:choice_sample_project/constants/constants.dart';
import 'package:choice_sample_project/repositories/post_repository.dart';
import 'package:choice_sample_project/widgets/error.dart';
import 'package:choice_sample_project/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class PostDetail extends StatefulWidget {
  final int id;

  const PostDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late Future<dynamic> _postDataState = PostRepository().getPost(widget.id);

  void retryGetPost() {
    setState(() {
      _postDataState = PostRepository().getPost(widget.id);
    });
  }

  Future<void> refreshGetPost(BuildContext context) {
    retryGetPost();
    return _postDataState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onPrimary,
              offset: const Offset(0, 1.0),
              blurRadius: 2.0,
            )
          ]),
          child: AppBar(
            elevation: 0.0,
            title: Text('Post ${widget.id}',
                style: Theme.of(context).textTheme.headline1),
            leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => Navigator.of(context).pop()),
          ),
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshGetPost(context),
        child: FutureBuilder(
            future: _postDataState,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                          maxWidth: Constants.maxWidth),
                      color: Theme.of(context).colorScheme.background,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: GestureDetector(
                          onLongPress: () async {
                            if (await Vibration.hasVibrator() != null) {
                              Vibration.vibrate(duration: 50);
                            }

                            SnackBar snackBar = SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              width: 230,
                              duration: const Duration(seconds: 2),
                              padding: const EdgeInsets.all(16),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Post Copied to Clipboard!',
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            );
                            Clipboard.setData(
                              ClipboardData(
                                  text:
                                      '${snapshot.data.title}\n\n${snapshot.data.body}'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(snapshot.data.title,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                ),
                                Text(snapshot.data.body,
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.bodyText1)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data == null) {
                return const Loading();
              } else {
                return Error(callback: retryGetPost);
              }
            }),
      ),
    );
  }
}
