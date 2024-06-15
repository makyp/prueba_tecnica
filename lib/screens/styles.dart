import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final TextStyle appBarTextStyle = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 28,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  static final TextStyle listItemTextStyle = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
    ),
  );

  static final TextStyle footerTextStyle = GoogleFonts.lato(
    textStyle: TextStyle(
      color: Colors.grey,
      fontSize: 16,
    ),
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: ClipPath(
        clipper: CustomAppBarClipper(),
        child: AppBar(
          title: Text(title, style: AppStyles.appBarTextStyle),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
