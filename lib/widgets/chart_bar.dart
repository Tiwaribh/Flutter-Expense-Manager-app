import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar>  with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return
  LayoutBuilder( builder: (ctx, constraint){

    return  Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 4,
          child: Container(
            width: 10,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    AnimatedSize(
                      child: FractionallySizedBox(
                        heightFactor: widget.spendingPctOfTotal,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      alignment: Alignment.center,
                      duration: Duration(seconds: 1),
                      curve: Curves.linear, vsync: this,
                    ),
                  ],
                ),
                // FractionallySizedBox(
                //   widthFactor: 0.5,
                //   heightFactor: spendingPctOfTotal,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.blue,
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            widget.spendingAmount.toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

  },);


  }
}
