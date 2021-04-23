import 'package:flutter_bolierplate_example/helpers/helpers.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';
import 'package:flutter/material.dart';
import './shimmer_box.dart';

class Loading extends StatelessWidget {
  // final String text;
  final double size;

  const Loading({
    Key key,
    // this.text,
    this.size = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size * 10,
              width: size * 10,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Shimmer(
            child: ShimmerBox(
              height: Device.maxWidth * 0.5,
              width: Device.maxWidth * 0.9,
            ),
          ),
          const SizedBox(height: 20),
          Shimmer(
            child: ShimmerBox(
              height: Device.maxWidth * 0.5,
              width: Device.maxWidth * 0.9,
            ),
          )
        ],
      ),
    );
  }
}
