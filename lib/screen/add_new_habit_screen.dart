import 'package:flutter/material.dart';
import 'package:habit_tracker/constant.dart';
import 'package:habit_tracker/model/habit_model.dart';
import 'package:intl/intl.dart';

class AddNewHabitScreen extends StatefulWidget {
  const AddNewHabitScreen({Key? key}) : super(key: key);

  @override
  State<AddNewHabitScreen> createState() => _AddNewHabitScreenState();
}

class _AddNewHabitScreenState extends State<AddNewHabitScreen> {
  String selectedValue = 'in minutes';
  final value = <String>['in minutes', 'in hours', 'in days'];
  final name = TextEditingController();
  final timeSpent = TextEditingController();
  final description = TextEditingController();
  final timeGoal = TextEditingController();
  int countDown = 1;

  Duration duration() {
    if (selectedValue == 'in minutes') {
      return Duration(minutes: countDown);
    } else if (selectedValue == 'in hours') {
      return Duration(hours: countDown);
    } else if (selectedValue == 'in days') {
      return Duration(days: countDown);
    }
    return const Duration();
  }

  @override
  Widget build(BuildContext context) {
    var t = DateTime.now().add(duration());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text('New Habit'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        validator: (val) =>
                            val!.isEmpty ? 'field is required' : null,
                        controller: name,
                        decoration: const InputDecoration(
                            labelText: 'Enter habit name'),
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        validator: (val) =>
                            val!.isEmpty ? 'field is required' : null,
                        controller: description,
                        decoration: const InputDecoration(
                            labelText: 'Enter description'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        validator: (val) =>
                            val!.isEmpty ? 'field is required' : null,
                        controller: timeGoal,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Enter time Goal'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                                isExpanded: true,
                                value: countDown,
                                items: List.generate(
                                    5,
                                    (i) => DropdownMenuItem<int>(
                                        value: i,
                                        child: Text(i.toString()))).toList(),
                                onChanged: (int? val) =>
                                    setState(() => countDown = val!)),
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: DropdownButtonFormField(
                                isExpanded: true,
                                value: selectedValue,
                                items: value
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (String? val) =>
                                    setState(() => selectedValue = val!)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Text(
                        'Your time elapses at ${DateFormat().format(t)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
              height: 58,
              color: Colors.lightGreen,
              minWidth: double.infinity,
              onPressed: () {
                var t = DateTime.now().add(duration());
                print(t);
                final habit = HabitModel(
                    name: "${name.text} $selectedValue",
                    duration: duration(),
                    startedAt: DateTime.now(),
                    timeSpent: 0,
                    description: description.text,
                    timeGoal: int.parse(timeGoal.text));

                Navigator.of(context).pop(habit);

                showSnackbar(context, t.toString());
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
