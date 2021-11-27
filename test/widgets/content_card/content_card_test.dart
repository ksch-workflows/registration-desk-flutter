// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/context.dart';
import 'package:registration_desk/widgets/content_card/index.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  setUpAll(initialiseInMemoryContext);

  testWidgets('Should render empty state of content card', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = ContentCard(
      title: ContentCardTitle(
        text: 'Widget test',
        icon: Icons.house,
      ),
      emptyState: Text('This is my empty state'),
    );

    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(find.text('This is my empty state'), findsOneWidget);
  });

  testWidgets('Should not render empty state', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = ContentCard(
      title: ContentCardTitle(
        text: 'Widget test',
        icon: Icons.house,
      ),
      emptyState: Text('This is my empty state'),
      info: [
        ContentCardInfo(key: 'Key 1', value: 'Value 1'),
      ],
    );

    await tester.pumpWidget(TestBench(
      child: Text('Hello, Widget!'),
      pageSize: Size(800, 600),
    ));

    expect(find.text('This is my empty state'), findsNothing);
  });

  testWidgets('Should render info text fields', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = ContentCard(
      title: ContentCardTitle(
        text: 'Widget test',
        icon: Icons.house,
      ),
      info: [
        ContentCardInfo(key: 'Key 1', value: 'Value 1'),
      ],
    );

    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(
      find.descendant(
        of: find.byType(TextField),
        matching: find.text('Key 1'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(TextField),
        matching: find.text('Value 1'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should render content card with buttons', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    var buttonClicked = false;

    var widget = ContentCard(
      title: ContentCardTitle(
        text: 'Widget test',
        icon: Icons.house,
      ),
      buttons: [
        ContentCardButton(
            title: 'Click me', onPressed: () => buttonClicked = true),
      ],
    );

    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    await tester.tap(
      find.descendant(
        of: find.byType(TextButton),
        matching: find.text('CLICK ME'),
      ),
    );
    expect(buttonClicked, isTrue);
  });

  testWidgets('Should render content card with icons', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    var iconClicked = false;

    var widget = ContentCard(
      title: ContentCardTitle(
        text: 'Widget test',
        icon: Icons.house,
      ),
      icons: [
        ContentCardIcon(icon: Icons.house, onPressed: () => iconClicked = true)
      ],
    );

    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    await tester.tap(
      find.descendant(
        of: find.byType(IconButton),
        matching: find.byIcon(Icons.house),
      ),
    );
    expect(iconClicked, isTrue);
  });
}
