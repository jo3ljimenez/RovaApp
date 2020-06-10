import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red[300],
              Colors.red[900],
            ],
          ),
        ),
      )
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      var path = Path();
      path.lineTo(0, size.height - 60);
      path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 60);
      path.lineTo(size.width, 0);
      path.close();
      return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}