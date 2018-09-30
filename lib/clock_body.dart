import 'package:flutter/material.dart';
import 'clock_face.dart';
import 'dart:math';

class ClockBody extends StatelessWidget {
  ClockBody();

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: 1.0,
      child: new Stack(
        children: <Widget>[

          new Container(
            width: double.infinity,
            child: CustomPaint(
              painter: new BellsAndLegPainter(),
            )
          ),

          new Container(
            width: double.infinity,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              boxShadow: [
                new BoxShadow(
                    offset: new Offset(0.0, 5.0),
                  blurRadius: 5.0
                )
              ]
            ),
            child: new ClockFace(),
          )
        ],
      ),
    );
  }
}


class BellsAndLegPainter extends CustomPainter {
  final Paint bellPaint;
  final Paint legPaint;

  BellsAndLegPainter():bellPaint = new Paint(), legPaint = new Paint() {
    //set the styles and properties for the painters
    bellPaint.color = const Color(0xFF333333);
    bellPaint.style = PaintingStyle.fill;

    legPaint.style  = PaintingStyle.stroke;
    legPaint.color = const Color(0xFF555555);
    legPaint.strokeWidth = 10.0;
    legPaint.strokeCap = StrokeCap.round;
  }


  @override
  void paint(Canvas canvas, Size size) { //canvas is the container declared above, size is the size of the widget
    // TODO: implement paint
    final radius = size.width / 2; //basically the middle of the page

    canvas.save(); //save the current state of the canvas
    canvas.translate(radius, radius);// change the position and size of the container. new origin-center

    //paint handle
    drawHandle(radius, canvas);

    canvas.rotate(0.523599); // 30 degrees
    drawBellAndLeg(radius, canvas); //draw the bell and leg with this current position of the container(middle of the page0)

    canvas.rotate(-1.0472);
    drawBellAndLeg(radius, canvas); //draw the bell and leg with this current position of the container(middle of the page0)

    canvas.restore(); //restore the canvas back to the position hat it was already saved


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

  void drawHandle(double radius, Canvas canvas) {

    //draw the handle
    Path path = new Path();
    path.moveTo(-60.0, -radius-10);
    path.lineTo(-50.0, -radius-50);
    path.lineTo(50.0, -radius-50);
    path.lineTo(60.0, -radius-10);

    canvas.drawPath(path, legPaint);


  }

  void drawBellAndLeg(double radius, Canvas canvas) {

    //draw bell
    Path path1 = new Path();
    path1.moveTo(-55.0, -radius-5);
    path1.lineTo(55.0, -radius-5); //only x, line to 55.0 from -radius - 5
    path1.quadraticBezierTo(0.0, -radius-75, -55.0, -radius-10);


    //leg
    Path path2= new Path();
    path2.addOval(new Rect.fromCircle(center: new Offset(0.0, -radius-50), radius: 3.0));
    path2.moveTo(0.0, -radius-50);
    path2.lineTo(0.0, radius+20);

    canvas.drawPath(path2, legPaint);
    canvas.drawPath(path1, bellPaint);
  }

}