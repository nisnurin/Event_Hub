import 'package:flutter_test/flutter_test.dart';
import 'package:event_hub_student/main.dart';

void main() {
  testWidgets('app launches with splash screen', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const EventHubApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
    });

    expect(find.text('e'), findsOneWidget);
  });
}
