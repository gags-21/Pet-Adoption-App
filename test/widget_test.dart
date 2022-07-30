// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pet_adoption_app_task/provider/pet_details_provider.dart';
import 'package:pet_adoption_app_task/screens/details_page.dart';
import 'package:provider/provider.dart';

void main() {
  // find widgets
  final adoptedButton = find.byKey(const ValueKey('adoptedButton'));
  final adoptButton = find.byKey(const ValueKey('adoptButton'));

  testWidgets('Adopt Button test', (WidgetTester tester) async {
    Widget testApp({required Widget child}) {
      return MaterialApp(
        home: ChangeNotifierProvider(
            create: (_) => PetDetailsProvider()..initialize(), child: child),
      );
    }

    // execute test
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        testApp(
          child: DetailsPage(
            pet: PetDetailsProvider().petDetails(1),
            index: 1,
          ),
        ),
      ),
    );
    await tester.tap(adoptButton);
    await tester.pump();

    // result
    expect(
        find.text(
            'You’ve now adopted \n 💙 ${PetDetailsProvider().petName(1)} 💙'),
        findsOneWidget);
  });

  testWidgets('Adopted Button test', (WidgetTester tester) async {
    Widget testApp({required Widget child}) {
      return MaterialApp(
        home: ChangeNotifierProvider(
            create: (_) => PetDetailsProvider()..initialize(), child: child),
      );
    }

    // execute test
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        testApp(
          child: DetailsPage(
            pet: PetDetailsProvider().petDetails(1),
            index: 1,
          ),
        ),
      ),
    );
    // await tester.tap(adoptButton);
    await tester.pump();

    // result
    expect(
        find.text(
            'You’ve now adopted \n 💙 ${PetDetailsProvider().petName(1)} 💙'),
        findsNothing);
  });
}
