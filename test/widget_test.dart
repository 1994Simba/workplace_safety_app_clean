import 'package:flutter_test/flutter_test.dart';
import 'package:workplace_safety_app_clean/main.dart';

void main() {
  testWidgets('App loads and shows title', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const WorkplaceSafetyApp());

    // Verify that the title text appears.
    expect(find.text('Workplace Safety'), findsOneWidget);
  });
}
