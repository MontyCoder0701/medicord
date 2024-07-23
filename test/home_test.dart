import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medicord/providers/record_list.dart';
import 'package:medicord/repositories/local.dart';
import 'package:medicord/screens/record/record_create.screen.dart';
import 'package:medicord/screens/record/record_list.screen.dart';
import 'package:medicord/screens/router.dart';
import 'package:medicord/screens/stat/stat.screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await LocalRepository.initialize();

  Widget createTestApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordListProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: CustomRouter.getConfig(),
      ),
    );
  }

  testWidgets('Navigate between Record and Stat screens',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();
    expect(find.byType(RecordListScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.calendar_month_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(StatScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.medical_services_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(RecordListScreen), findsOneWidget);
  });

  testWidgets('Validate record creation', (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();
    expect(find.byType(RecordListScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(RecordCreateScreen), findsOneWidget);
    expect(find.text('새 기록 생성'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();
    expect(find.text('필수 항목입니다'), findsNWidgets(6));

    await tester.enterText(find.byType(TextFormField).at(0), '10');
    await tester.enterText(find.byType(TextFormField).at(1), '20');
    await tester.enterText(find.byType(TextFormField).at(2), '70');
    await tester.enterText(find.byType(TextFormField).at(3), '120');
    await tester.enterText(find.byType(TextFormField).at(4), '80');
    await tester.enterText(find.byType(TextFormField).at(5), '37.0');
    await tester.pump();

    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();
    expect(find.byType(RecordCreateScreen), findsNothing);
  });
}
