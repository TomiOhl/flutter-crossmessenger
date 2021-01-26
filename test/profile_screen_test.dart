import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotprog/db/db_access.dart';
import 'package:kotprog/db/sql.dart';
import 'package:kotprog/languages/localizations.dart';

import 'package:kotprog/models/profile.dart';
import 'package:kotprog/profile_screen.dart';
import 'package:provider/provider.dart';

// Mediaquery se szálljon el
Widget makeTestableWidget(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  Sql sql = Sql();

  testWidgets('Can set nickname', (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
        Localizations(
          locale: Locale('en', 'EN'),
          delegates: [
            CustomLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => Profile(),
                ),
                Provider(
                  create: (_) => DbAccess(sql: sql),
                ),
              ],
              child: ProfilePage(),
          ),
        ),
      ),
    );

    expect(find.text('Tomi_Ohl'), findsNothing);

    await tester.enterText(find.byType(TextFormField).first, 'Tomi_Ohl');
    await tester.tap(find.byType(RaisedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('Tomi_Ohl'), findsWidgets);
  });
}