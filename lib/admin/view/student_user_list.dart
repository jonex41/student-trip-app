import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_project/admin/provider/admin_provider.dart';

import '../../utils/constants.dart';
import '../user_location/views/user_location_page.dart';
import '../user_location/views/user_statistic.dart';

class StudentUserPage extends ConsumerWidget {
  const StudentUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userListProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Student User'),
        ),
        body: state.when(
            data: (data) => data.isEmpty
                ? const Center(child: Text('An error occurred'))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ListTile(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLocationPage(
                                    id: data[index].id!,
                                    type: kStudentBase,
                                    model: data[index])),
                          );
                        }),
                        leading: CircleAvatar(
                          radius: 16.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: data[index].urlImage == null
                                ? Container()
                                : Image.network(data[index].urlImage!),
                          ),
                        ),
                        title: Text(data[index].name!),
                        subtitle: Text(data[index].address!),
                        trailing: GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserStatisticPage(
                                        id: data[index].id!,
                                        type: kStudent,
                                        model: data[index])),
                              );
                            }),
                            child: const Icon(
                              PhosphorIcons.chart_line_up,
                            )),
                      );
                    }),
            error: (_, __) => const Center(child: Text('An error occurred')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
