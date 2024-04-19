import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;

  BigText(
      {Key? key,
      this.color = const Color(0xFF332b2b),
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.normal,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 500,
      overflow: overflow,
      style:
      // GoogleFonts.poppins(
      //   textStyle:
        TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size == 0 ? 20 : size,

          // fontFamily: 'Publica Sans Round',
        ),
      // ),
    // ),

    );
  }
}
