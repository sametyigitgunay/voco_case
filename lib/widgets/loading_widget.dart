import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({super.key, this.isLoading, required this.child});
  bool? isLoading;
  Widget child;
  final _errorText = "Bir hata oluştu, lütfen daha sonra tekrar deneyiniz";

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (isLoading == false) {
      return Center(
        child: Text(_errorText),
      );
    }else {
      return child;
    }
   }
}
