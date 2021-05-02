import 'package:flutter/material.dart';

class CurvedWidget extends StatelessWidget {
  final Widget child;
  final double curvedDistance;
  final double curvedHeight;

<<<<<<< Updated upstream
  const CurvedWidget(
      {Key key, this.child, this.curvedDistance = 80, this.curvedHeight = 80})
      : super(key: key);
=======

  const CurvedWidget({Key key, this.child, this.curvedDistance = 80, this.curvedHeight = 80})
      :super(key:key);
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedWidgetBackgroundClipper(
<<<<<<< Updated upstream
          curvedHeight: curvedHeight, curvedDistance: curvedDistance),
=======

        curvedHeight: curvedHeight,
        curvedDistance: curvedDistance
      ),

>>>>>>> Stashed changes
      child: child,
    );
  }
}

class CurvedWidgetBackgroundClipper extends CustomClipper<Path> {
  final double curvedDistance;
  final double curvedHeight;

  CurvedWidgetBackgroundClipper({this.curvedDistance, this.curvedHeight});

  @override
  getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.lineTo(size.width, 0);
    clippedPath.lineTo(size.width, size.height - curvedDistance - curvedHeight);
<<<<<<< Updated upstream
    clippedPath.quadraticBezierTo(size.width, size.height - curvedHeight,
        size.width - curvedDistance, size.height - curvedHeight);
    clippedPath.lineTo(curvedDistance, size.height - curvedHeight);
    clippedPath.quadraticBezierTo(
        0, size.height - curvedHeight, 0, size.height);
=======

    clippedPath.quadraticBezierTo(size.width, size.height - curvedHeight, size.width - curvedDistance, size.height - curvedHeight);
    clippedPath.lineTo(curvedDistance, size.height - curvedHeight);
    clippedPath.quadraticBezierTo(0, size.height - curvedHeight, 0, size.height);

>>>>>>> Stashed changes
    return clippedPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
