# Experiment 7 – Application State Management and Serialization

**GitHub Repository:** [https://github.com/abelmathew25/exp-no-7](https://github.com/abelmathew25/exp-no-7)  
**Live Demo:** [https://abelmathew25.github.io/exp-no-7/](https://abelmathew25.github.io/exp-no-7/)

---

## Aim
To manage application state and serialize/deserialize data using JSON in Flutter.

---

## Step-by-Step Implementation

### Step 1: Create Project
```bash
flutter create state_app
cd state_app
code .
```

### Step 2: Create Student Model
Create file: `lib/student.dart`
```dart
class Student {
  final int id;
  final String name;
  final String course;

  Student({
    required this.id,
    required this.name,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      course: json['course'],
    );
  }
}
```

### Step 3: Create Student Object
```dart
Student student = Student(
  id: 1,
  name: 'Raj',
  course: 'CSE',
);
```

### Step 4: Convert Object to JSON
```dart
Map<String, dynamic> data = student.toJson();
print(data);
// Output: {id: 1, name: Raj, course: CSE}
```

### Step 5: Convert JSON Back to Object
```dart
Student newStudent = Student.fromJson(data);
print(newStudent.name);
// Output: Raj
```

### Step 6: Add State
```dart
List<String> students = [];

setState(() {
  students.add('Raj');
});
```

### Step 7: Display List
```dart
ListView.builder(
  itemCount: students.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(students[index]),
    );
  },
)
```

---

## Expected Result
The application maintains changing student data and converts structured data between Dart objects and JSON.

---

## Project Structure
```text
state_app/
├── .github/workflows/deploy.yml   # Automatic GitHub Pages deployment
├── bin/
│   └── experiment7_demo.dart      # Standalone CLI execution script
├── lib/
│   ├── main.dart                  # Complete UI with state management & JSON demonstration
│   └── student.dart               # Student model with toJson() & fromJson()
├── test/
│   └── widget_test.dart           # Automated test suite for model & UI
└── pubspec.yaml
```

---

## Running the Application

### 1. Run Flutter App
```bash
flutter run
```
Or for web (Chrome):
```bash
flutter run -d chrome
```

### 2. Run Standalone CLI Script
```bash
dart run bin/experiment7_demo.dart
```

### 3. Run Automated Tests
```bash
flutter test
```
