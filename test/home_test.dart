import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medicord/providers/record.dart';
import 'package:medicord/repositories/local.dart';
import 'package:medicord/screens/record/record_list.screen.dart';
import 'package:medicord/screens/router.dart';
import 'package:medicord/screens/stat/stat.screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Navigation Test', () {
    setUp(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      await LocalRepository.initialize();
    });

    Widget createTestApp() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RecordProvider()),
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
  });
}
