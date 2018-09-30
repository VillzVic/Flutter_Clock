import 'dart:math';

import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  final Paint hourhandPaint;
  int hours;
  int minutes;

  HourHandPainter({this.hours, this.minutes}) :hourhandPaint = new Paint(){
    hourhandPaint.color = Colors.black87;
    hourhandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final radius = size.width / 2;
    //draw your hand
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(this.hours>=12 ?
    2*PI*((this.hours-12)/12 + (this.minutes/720)):
    2*PI*((this.hours/12) + (this.minutes/720))
    );

    Path path= new Path();

    //heart shape head for the hour hand
    path.moveTo(0.0, -radius +15.0);
    path.quadraticBezierTo(-3.5, -radius + 25.0, -15.0, -radius+radius/4);
    path.quadraticBezierTo(-20.0, -radius+radius/3, -7.5, -radius+radius/3);
    path.lineTo(0.0, -radius+radius/4);
    path.lineTo(7.5, -radius+radius/3);
    path.quadraticBezierTo(20.0, -radius+radius/3, 15.0, -radius+radius/4);
    path.quadraticBezierTo(3.5, -radius + 25.0, 0.0, -radius+15.0);

    //hour hand stem
    path.moveTo(-1.0, -radius+radius/4);
    path.lineTo(-5.0, -radius+radius/2);
    path.lineTo(-2.0, 0.0);
    path.lineTo(2.0, 0.0);
    path.lineTo(5.0, -radius+radius/2);
    path.lineTo(1.0, -radius+radius/4);
    path.close();

    canvas.drawPath(path, hourhandPaint);
    canvas.drawShadow(path, Colors.black, 2.0, false);


    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}