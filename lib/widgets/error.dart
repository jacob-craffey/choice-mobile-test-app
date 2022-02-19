import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({Key? key, required this.callback}) : super(key: key);

  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Error getting data.\nPlease try again',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextButton(
              onPressed: callback,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16))),
              child: const Text(
                'Retry',
                style: TextStyle(
                    color: Color.fromARGB(255, 05, 0, 255), fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
