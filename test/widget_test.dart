import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/main.dart';
import 'package:state_app/student.dart';

void main() {
  test('Student model serialization and deserialization (Steps 2-5)', () {
    // Step 3: Create student object
    Student student = Student(
      id: 1,
      name: 'Raj',
      course: 'CSE',
    );

    // Step 4: Convert object to JSON
    Map<String, dynamic> data = student.toJson();
    expect(data['id'], 1);
    expect(data['name'], 'Raj');
    expect(data['course'], 'CSE');

    // Step 5: Convert JSON back to object
    Student newStudent = Student.fromJson(data);
    expect(newStudent.id, 1);
    expect(newStudent.name, 'Raj');
    expect(newStudent.course, 'CSE');
  });

  testWidgets('Experiment 7 UI and State Management test (Steps 6-7)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Initially _executeExperimentSteps() is called in initState, so 'Raj' is in the list
    expect(find.text('Raj'), findsWidgets);
    expect(find.text('Count: 1'), findsOneWidget);

    // Tap the floating action button to add 'Raj' to state via setState
    await tester.tap(find.byTooltip("Add 'Raj' to State"));
    await tester.pump();

    // Verify count increased to 2
    expect(find.text('Count: 2'), findsOneWidget);
  });
}
