import 'package:flutter_test/flutter_test.dart';
import 'package:fittrack/main.dart';

void main() {
  testWidgets('FitTrack shows the three modules', (tester) async {
    await tester.pumpWidget(const FitTrackApp());

    expect(find.text('BMI'), findsOneWidget);
    expect(find.text('Calories'), findsOneWidget);
    expect(find.text('Workout'), findsOneWidget);
  });
}
