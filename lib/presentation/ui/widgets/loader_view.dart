import 'package:flutter/material.dart';
import 'package:movie_search/constants/string_constants.dart';

class LoaderView extends StatelessWidget {
  final String message;
  const LoaderView({super.key, this.message = StringConstants.msgLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
