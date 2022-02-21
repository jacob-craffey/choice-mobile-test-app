import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final void Function() callback;
  const Error({Key? key, required this.callback}) : super(key: key);

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
                const EdgeInsets.fromLTRB(50, 16, 50, 16),
              )),
              child: Text(
                'Retry',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
