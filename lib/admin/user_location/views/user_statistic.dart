import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/model/register_model.dart';

class UserStatisticPage extends ConsumerWidget {
  const UserStatisticPage(
      {super.key, required this.id, required this.type, required this.model});
  final String id;
  final String type;
  final RegisterModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = DateFormat('dd MMM, yyyy').format(DateTime.now());
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay = localizations.formatTimeOfDay(TimeOfDay.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Statistics'),
      ),
      body: ListView(
        // horizontal).
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          10.height,
          Row(
            children: [
              const Text(
                'Name :',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
              Text(
                model.name!,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              )
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Person ID :',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
              Text(
                model.personId!,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              )
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Department ID:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
              Text(
                model.departmentId!,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Phone NO:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
              Text(
                model.phone!,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Time/Date:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
              Text(
                '$formattedTimeOfDay: $date',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Weekly:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
               Text(
                model.count??'0',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          40.height,
          Row(
            children: [
              const Text(
                'Year:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              10.width,
               Text(
                model.count??'0',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          40.height,
          /*  ElevatedButton(onPressed: () {}, child: const Text('Print')) */
        ],
      ),
    );
  }
}
