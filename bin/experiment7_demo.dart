import '../lib/student.dart';

void main() {
  print('--- EXPERIMENT 7: DART & JSON SERIALIZATION ---');

  // Step 3 – Create student object
  Student student = Student(
    id: 1,
    name: 'Raj',
    course: 'CSE',
  );

  // Step 4 – Convert object to JSON
  Map<String, dynamic> data = student.toJson();
  print('Step 4 Output:');
  print(data);

  // Step 5 – Convert JSON back to object
  Student newStudent = Student.fromJson(data);
  print('Step 5 Output:');
  print(newStudent.name);

  // Step 6 & 7 Demonstration
  print('Step 6 & 7 Output:');
  List<String> students = [];
  students.add('Raj');
  print('Students list: $students');
  print('Experiment completed successfully.');
}
