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
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 245, 245, 245),
            spreadRadius: 3,
            blurRadius: 40,
            blurStyle: BlurStyle.outer,
          ),
        ],

        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          Text(
            widget.transcription,
            style: TextStyle(fontFamily: 'NotoSans_SemiCondensed'),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.black12),
          Text(widget.definition),
        ],
      ),
    );
  }
}
