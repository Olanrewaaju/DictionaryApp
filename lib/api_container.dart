import 'package:flutter/material.dart';

class ApiContainer extends StatefulWidget {
  final String name;
  final String transcription;
  final String definition;
  const ApiContainer({
    super.key,
    required this.name,
    required this.transcription,
    required this.definition,
  });

  @override
  State<ApiContainer> createState() => _ApiContainerState();
}

class _ApiContainerState extends State<ApiContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: 200,
      height: 160,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: const Color.fromARGB(31, 150, 150, 150)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 222, 222, 222),
            spreadRadius: 3,
            blurRadius: 400,
            // blurStyle: BlurStyle.outer,
          ),
        ],

        color: const Color.fromARGB(255, 250, 250, 250),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          Text(
            widget.transcription,
            style: TextStyle(
              fontFamily: 'NotoSans_SemiCondensed',
              fontSize: 12,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.black26),
          SizedBox(height: 12),

          Text(
            '${widget.definition} ',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
