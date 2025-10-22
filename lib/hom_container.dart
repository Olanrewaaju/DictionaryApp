import 'package:flutter/material.dart';

class HomContainer extends StatefulWidget {
  final String name;
  final String transcription;
  final String firstdefinition;
  final String seconddefinition;
  const HomContainer({
    super.key,
    required this.name,
    required this.transcription,
    required this.firstdefinition,
    required this.seconddefinition,
  });

  @override
  State<HomContainer> createState() => _HomContainerState();
}

class _HomContainerState extends State<HomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      width: 300,
      height: 220,
      decoration: BoxDecoration(
        // border: BoxBorder.all(color: const Color.fromARGB(31, 150, 150, 150)),
        borderRadius: BorderRadius.circular(12),

        // boxShadow: [
        //   BoxShadow(
        //     color: const Color.fromARGB(255, 222, 222, 222),
        //     spreadRadius: 3,
        //     blurRadius: 400,
        //     // blurStyle: BlurStyle.outer,
        //   ),
        // ],
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          Text(
            widget.transcription,
            softWrap: true,

            style: TextStyle(
              fontFamily: 'NotoSans_SemiCondensed',
              fontSize: 10,
            ),
          ),
          SizedBox(height: 30),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,

              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${widget.firstdefinition} ',
                        softWrap: true,

                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 60,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    width: 20,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${widget.seconddefinition} ',
                        softWrap: true,

                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
