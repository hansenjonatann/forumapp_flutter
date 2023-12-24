import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hansen Jonatan',
            style: GoogleFonts.poppins(),
          ),
          Text(
            'hansenjonatann@gmail.com',
            style: GoogleFonts.poppins(
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 10),
          Text('I am a web developer and mobile developer'),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.thumb_up),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.comment_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
