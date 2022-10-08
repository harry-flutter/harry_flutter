import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Elixirs', style: TextStyle(fontSize: 26.0, color: Colors.black)),
              Icon(Icons.sort_by_alpha),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 60,
                          color: Colors.black,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4.0),
                          height: 40,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
