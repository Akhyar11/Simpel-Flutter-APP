import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';

void main() {
  group('MyHomePage Widget Tests', () {
    testWidgets('Renders all main components', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Beranda'),
      ));

      // Verify AppBar
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);

      // Verify Search Bar
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Verify Menu Section
      expect(find.text('Menu Utama'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);

      // Verify News Section
      expect(find.text('Berita Terbaru'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Menu grid shows correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Beranda'),
      ));

      // Verify all 8 menu items are present
      expect(find.byKey(const Key('menuGrid')), findsOneWidget);
      for (int i = 0; i < 8; i++) {
        expect(find.byKey(Key('menuItem_$i')), findsOneWidget);
      }
    });

    testWidgets('News list shows correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Beranda'),
      ));

      // Verify 5 news items are present
      expect(find.byKey(const Key('newsList')), findsOneWidget);
      for (int i = 0; i < 5; i++) {
        expect(find.byKey(Key('newsCard_$i')), findsOneWidget);
      }
    });
  });
}