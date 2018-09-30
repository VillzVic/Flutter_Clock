import 'package:flutter/material.dart';
import 'dart:math';

class ClockDialPainter extends CustomPainter{
  final clockText;


  final hourTickMarkLength= 10.0;
  final minuteTickMarkLength = 5.0;

  final hourTickMarkWidth= 3.0;
  final minuteTickMarkWidth = 1.5;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  final romanNumeralList= [ 'XII','I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI'];


  ClockDialPainter({this.clockText = ClockText.roman})
          : tickPaint= new Paint(),
            textPainter= new TextPainter(
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl
            ),
            textStyle= const TextStyle(
            color: Colors.black,
//            fontFamily: 'Times New Roman',
            fontSize: 15.0,
        ) {
         tickPaint.color= Colors.blueGrey;
        }

  @override
  void paint(Canvas canvas, Size size) {

    var tickMarkLength;
    final angle= 2* PI / 60;
    final radius= size.width/2;

    canvas.save();

    // drawing
    canvas.translate(radius, radius);

    for(var i = 0; i< 60; i++){

      //make the length and stroke of the tick marker longer and thicker depending on if it is hour or minute
      tickMarkLength= i % 5 == 0 ? hourTickMarkLength: minuteTickMarkLength;
      tickPaint.strokeWidth= i % 5 == 0 ? hourTickMarkWidth : minuteTickMarkWidth;

      canvas.drawLine(
          new Offset(0.0, -radius), new Offset(0.0, -radius+tickMarkLength), tickPaint); //draw a line from start to end for hour and minute

      //draw the text for hours only
      if (i%5==0){
        canvas.save();
        canvas.translate(0.0, -radius+20.0);

        textPainter.text= new TextSpan(
          text: this.clockText==ClockText.roman?
          '${romanNumeralList[i~/5]}'
              :'${i == 0 ? 12 : i~/5}'
          ,
          style: textStyle,
        );

        //rotate the painting by every 6 * i degree except for the first one
        canvas.rotate(-angle*i);

        textPainter.layout(); //layout the text


        textPainter.paint(canvas, new Offset(-(textPainter.width/2), -(textPainter.height/2))); //paint the text finally

        canvas.restore(); //restore the canvas so that we can paint again

      }

      canvas.rotate(angle); //if it is not hour, rotate the canvas by 6 degree so we can paint again
    }

    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }


}

enum ClockText{
  roman,
  arabic
}