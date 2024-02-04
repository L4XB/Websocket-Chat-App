import 'package:flutter/material.dart';

class ChannelElemnt extends StatelessWidget {
  final String channelName;
  final Function onpress;
  const ChannelElemnt(
      {super.key, required this.channelName, required this.onpress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onpress(),
      child: Container(
        width: screenWidth,
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 217, 217),
            border: Border.all(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(child: Text("Channel name :$channelName")),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
