import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/main.dart';

void main() {
  testWidgets('renders login home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('HQSOFT'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Bắt đầu'), findsOneWidget);
  });
}
