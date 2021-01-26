import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotprog/db/db_access.dart';
import 'package:kotprog/db/sql.dart';
import 'package:kotprog/languages/localizations.dart';

import 'package:kotprog/main.dart';
import 'package:kotprog/models/profile.dart';
import 'package:provider/provider.dart';

void main() {
  Sql sql = Sql();

  testWidgets('Title is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(
        Provider(
          create: (_) => DbAccess(sql: sql),
            child: MyApp()
        ),
    );

    await tester.pump();

    expect(find.text('Kiskutya'), findsNothing);
    expect(find.text('CrossMessenger'), findsOneWidget);
  });

  testWidgets('Dialog is displayed on fab press', (WidgetTester tester) async {
    await tester.pumpWidget(
        Localizations(
          locale: Locale('en', 'EN'),
          delegates: [
            CustomLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          child: Provider(
            create: (_) => DbAccess(sql: sql),
              child: MyApp()
          ),
        ),
    );

    expect(find.text('Cancel'), findsNothing);

    await tester.tap(find.byIcon(Icons.add_outlined));
    await tester.pump();

    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Can get to Profile', (WidgetTester tester) async {
    await tester.pumpWidget(
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
            child: MyApp(),
        ),
      ),
    );

    expect(find.text('Map'), findsNothing);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.text('Map'), findsOneWidget);
  });
}