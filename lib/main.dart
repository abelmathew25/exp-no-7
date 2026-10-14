import 'dart:convert';
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 7 - State Management & JSON',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const StudentAppPage(),
    );
  }
}

class StudentAppPage extends StatefulWidget {
  const StudentAppPage({super.key});

  @override
  State<StudentAppPage> createState() => _StudentAppPageState();
}

class _StudentAppPageState extends State<StudentAppPage> {
  // Step 6 – Create a list
  List<String> students = [];

  // State to track JSON serialization details for UI demonstration
  String _jsonDisplay = '';
  String _deserializedDisplay = '';
  int _counter = 1;

  final TextEditingController _nameController = TextEditingController(text: 'Raj');
  final TextEditingController _courseController = TextEditingController(text: 'CSE');

  @override
  void initState() {
    super.initState();
    // Execute the exact experiment steps on launch
    _executeExperimentSteps();
  }

  void _executeExperimentSteps() {
    // Step 3 – Create student object
    Student student = Student(
      id: 1,
      name: 'Raj',
      course: 'CSE',
    );

    // Step 4 – Convert object to JSON
    Map<String, dynamic> data = student.toJson();
    // ignore: avoid_print
    print(data);

    // Step 5 – Convert JSON back to object
    Student newStudent = Student.fromJson(data);
    // ignore: avoid_print
    print(newStudent.name);

    // Step 6 – Add state
    setState(() {
      students.add(newStudent.name);
      _jsonDisplay = jsonEncode(data);
      _deserializedDisplay =
          'ID: ${newStudent.id}, Name: ${newStudent.name}, Course: ${newStudent.course}';
    });
  }

  void _addCustomStudent() {
    final name = _nameController.text.trim();
    final course = _courseController.text.trim();
    if (name.isEmpty) return;

    _counter++;
    // Step 3 – Create student object
    Student student = Student(
      id: _counter,
      name: name,
      course: course.isEmpty ? 'General' : course,
    );

    // Step 4 – Convert object to JSON
    Map<String, dynamic> data = student.toJson();
    // ignore: avoid_print
    print(data);

    // Step 5 – Convert JSON back to object
    Student newStudent = Student.fromJson(data);
    // ignore: avoid_print
    print(newStudent.name);

    // Step 6 – Add state
    setState(() {
      students.add(newStudent.name);
      _jsonDisplay = jsonEncode(data);
      _deserializedDisplay =
          'ID: ${newStudent.id}, Name: ${newStudent.name}, Course: ${newStudent.course}';
    });

    _nameController.clear();
  }

  void _clearList() {
    setState(() {
      students.clear();
      _jsonDisplay = '';
      _deserializedDisplay = '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management & JSON Serialization'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Run Default Experiment Steps',
            onPressed: _executeExperimentSteps,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear List',
            onPressed: _clearList,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Experiment Header Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPERIMENT 7',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Aim: To manage application state and serialize/deserialize data using JSON.',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Step 4 & 5 Verification Card
            Card(
              elevation: 2,
              color: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.code, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text(
                          'Step 4 & 5: JSON Serialization Inspection',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      'Serialized JSON (student.toJson()):',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.indigo.shade200),
                      ),
                      child: Text(
                        _jsonDisplay.isEmpty ? 'No data serialized yet.' : _jsonDisplay,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Deserialized Object (Student.fromJson(data)):',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.indigo.shade200),
                      ),
                      child: Text(
                        _deserializedDisplay.isEmpty
                            ? 'No data deserialized yet.'
                            : _deserializedDisplay,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Form to Add New Student
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Student via Model & JSON Conversion',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Student Name',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _courseController,
                            decoration: const InputDecoration(
                              labelText: 'Course',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _addCustomStudent,
                      icon: const Icon(Icons.add),
                      label: const Text('Convert to JSON, Parse & Add to State'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(42),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Step 6 & 7: State List Display
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Step 7: Student List (Application State)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Count: ${students.length}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    const Divider(),
                    students.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                              child: Text(
                                'No students in state. Click + or reload.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            // Step 7 – Display list
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.indigo.shade100,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  students[index],
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text('Index: $index'),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add 'Raj' to State",
        onPressed: () {
          // Exactly matches Step 6:
          // setState(() {
          //   students.add('Raj');
          // });
          setState(() {
            students.add('Raj');
          });
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
