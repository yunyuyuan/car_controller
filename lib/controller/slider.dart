import 'dart:math';

import 'package:flutter/material.dart';

enum Orients { vertical, horizontal }
final grooveDecoration = BoxDecoration(
    color: Color(0xFF7CBAFF),
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      BoxShadow(
          color: Color(0xFFE9FFDA),
          spreadRadius: 0,
          blurRadius: 3,
          offset: Offset(0, 0))
    ]);
final disabledGrooveDecoration = BoxDecoration(
    color: Color(0xFFCDCDCD),
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      BoxShadow(
          color: Color(0xFF8E8E8E),
          spreadRadius: 0,
          blurRadius: 3,
          offset: Offset(0, 0))
    ]);
final trackDecoration = BoxDecoration(color: Color(0xFF0022FF), boxShadow: [
  BoxShadow(
      color: Color(0xFF1070FF),
      spreadRadius: 0,
      blurRadius: 4,
      offset: Offset(0, 0))
]);
final thumbDecoration = BoxDecoration(
    color: Color(0xFFFFA200),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
          color: Color(0xFF5A5A5A),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 0))
    ]);
final disabledThumbDecoration = BoxDecoration(
    color: Color(0xFF717171),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
          color: Color(0xFF5A5A5A),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 0))
    ]);


class MySlider extends StatefulWidget {
  final Orients orient;
  final Function valueChange;
  final bool disabled;

  MySlider({this.orient, this.valueChange, this.disabled}) : super();

  @override
  State createState() => SliderState();
}

class SliderState extends State<MySlider> {
  final double grooveWidth = 200;
  final double thumbSize = 40;
  final double grooveHeight = 10;

  double valueNow = 0;
  final double divide = 10;

  void valueChange(){
    widget.valueChange(valueNow);
  }

  @override
  Widget build(Object context) {
    double totalWidth = grooveWidth + thumbSize;
    double maxStep = grooveWidth / (2 * divide);
    Function reset = (){
      if (widget.disabled) return;
      setState(() {
        valueNow = 0;
      });
      valueChange();
    };
    Function handle = (e){
      if (widget.disabled) return;
      double x = (widget.orient==Orients.horizontal?e.localPosition.dx:e.localPosition.dy )- thumbSize / 2;
      if (x >= 0 && x <= grooveWidth) {
        var newValue = (x / divide).round().toDouble() - maxStep;
        if (valueNow == newValue) return;
        setState(() {
          valueNow = newValue;
        });
        valueChange();
      }
    };
    if (widget.orient == Orients.horizontal) {
      return GestureDetector(
        onHorizontalDragUpdate: (e) {
          handle(e);
        },
        onTapDown: (e) {
          handle(e);
        },
        onTapUp: (e) {
          reset();
        },
        onHorizontalDragEnd: (e) {
          reset();
        },
        child: SizedBox(
          width: totalWidth,
          height: thumbSize,
          child: Stack(children: [
            /* background.for capturing touch event */
            Positioned(
                left: 0,
                top: 0,
                width: totalWidth,
                height: thumbSize,
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                )),
            /* groove */
            Positioned(
                left: thumbSize / 2,
                top: (thumbSize - grooveHeight) / 2,
                width: grooveWidth,
                height: grooveHeight,
                child: Container(
                  decoration: widget.disabled?disabledGrooveDecoration:grooveDecoration,
                )),
            /* track */
            Positioned(
                left: totalWidth / 2,
                top: (thumbSize - grooveHeight) / 2,
                width: valueNow.abs() * divide,
                height: grooveHeight,
                child: Transform.rotate(
                    angle: valueNow < 0 ?pi : 0,
                    child: Container(
                      decoration: trackDecoration,
                    ))),
            /* thumb */
            Positioned(
                left: grooveWidth / 2 + valueNow * divide,
                top: 0,
                width: thumbSize,
                height: thumbSize,
                child: Container(
                  decoration: widget.disabled?disabledThumbDecoration:thumbDecoration,
                )),
          ]),
        ),
      );
    } else {

      return GestureDetector(
        onVerticalDragUpdate: (e) {
          handle(e);
        },
        onTapDown: (e) {
          handle(e);
        },
        onTapUp: (e) {
          reset();
        },
        onVerticalDragEnd: (e) {
          reset();
        },
        child: SizedBox(
          height: totalWidth,
          width: thumbSize,
          child: Stack(children: [
            /* background.for capturing touch event */
            Positioned(
                left: 0,
                top: 0,
                width: thumbSize,
                height: totalWidth,
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                )),
            /* groove */
            Positioned(
                left: (thumbSize - grooveHeight) / 2,
                top: thumbSize / 2,
                width: grooveHeight,
                height: grooveWidth,
                child: Container(
                  decoration: widget.disabled?disabledGrooveDecoration:grooveDecoration,
                )),
            /* track */
            Positioned(
                left: (thumbSize - grooveHeight) / 2,
                top: totalWidth / 2,
                width: grooveHeight,
                height: valueNow.abs() * divide,
                child: Transform.rotate(
                    angle: valueNow < 0 ? pi : 0,
                    child: Container(
                      decoration: trackDecoration,
                    ))),
            /* thumb */
            Positioned(
                left: 0,
                top: grooveWidth / 2 + valueNow * divide,
                width: thumbSize,
                height: thumbSize,
                child: Container(
                  decoration: widget.disabled?disabledThumbDecoration:thumbDecoration,
                )),
          ]),
        ),
      );
    }
  }
}
