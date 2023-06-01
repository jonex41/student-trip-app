import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:student_project/admin/provider/admin_provider.dart';

import '../../utils/constants.dart';
import '../user_location/views/user_location_page.dart';
import '../user_location/views/user_statistic.dart';

class OperatorUserPage extends ConsumerWidget {
  const OperatorUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operatorListProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Operator User'),
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
                                    type: kOperatorBase,
                                    model: data[index])),
                          );
                        }),
                        leading: CircleAvatar(
                          radius: 16.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset('assets/images/logo.jpg'),
                          ),
                        ),
                        title: Text(data[index].name ?? 'Unknown'),
                        subtitle: Text(data[index].address ?? "Address"),
                        trailing: GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserStatisticPage(
                                        id: data[index].id!,
                                        type: kOperator,
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
