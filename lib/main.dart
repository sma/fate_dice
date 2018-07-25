import 'dart:math';

import 'package:fate_dice/fate_die.dart';
import 'package:flutter/material.dart';

final r = Random();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fate Dice',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Fate Dice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final int count = 4;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> values;

  @override
  void initState() {
    super.initState();
    _roll();
  }

  void _roll() {
    values = List<int>.generate(widget.count, (_) => r.nextInt(3) - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: spacedOut(Size(0.0, 16.0), [
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 16.0,
              // mainAxisSize: MainAxisSize.min,
              children: spacedOut(
                  Size(8.0, 0.0),
                  values.map((value) {
                    return Transform(
                      transform: Matrix4.rotationZ(_randomRotation())
                        ..translate(0.0, _randomRotation() * 20),
                      alignment: Alignment.center,
                      child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: FateDie(
                            key: ValueKey(value),
                            value: value,
                          )),
                    );
                  }).toList()),
            ),
            Text(
              _result(),
              style: Theme.of(context).textTheme.display2,
            ),
            CircularButton(
              onPressed: () {
                setState(_roll);
              },
              child: Text("Roll"),
            ),
          ]),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String _result() {
    final result = values.reduce((a, b) => a + b);
    return result > 0 ? "+$result" : "$result";
  }

  double _randomRotation() {
    return (r.nextInt(2) == 0 ? -r.nextDouble() : r.nextDouble()) / 3;
  }
}

class CircularButton extends StatelessWidget {
  CircularButton({
    this.onPressed,
    this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.deepOrangeAccent,
      textColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        width: 56.0 * 2,
        height: 56.0 * 2,
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 28.0,
            ),
            child: child,
          ),
        ),
      ),
      shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
    );
  }
}

List<Widget> spacedOut(Size spacing, List<Widget> children) {
  if (spacing.width <= 0 && spacing.height <= 0) {
    return children;
  }
  List<Widget> spacedOutChildren = [];
  for (var index = 0; index < children.length; index++) {
    if (index > 0) {
      spacedOutChildren.add(SizedBox.fromSize(size: spacing));
    }
    spacedOutChildren.add(children[index]);
  }
  return spacedOutChildren;
}
