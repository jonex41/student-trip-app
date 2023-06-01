import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/provider/admin_provider.dart';

class WeeklyReportPage extends HookConsumerWidget {
  const WeeklyReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vehicleListProvider);
    final controller = useTextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tickets Details'),
        ),
        body: ListView(children: [
          10.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // red as border color
                      ),
                    ),
                    child: const Text(
                      'S/N      ',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // red as border color
                      ),
                    ),
                    child: const Text(
                      'Trips in Progress',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // red as border color
                      ),
                    ),
                    child: const Text(
                      'Vehicle in Queue',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // red as border color
                      ),
                    ),
                    child: const Text(
                      'Comleted Trip',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // red as border color
                      ),
                    ),
                    child: const Text(
                      'Date/Time',
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
          state.when(
              data: (data) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      onTap: (() {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserLocationPage(
                                  id: data[index].id!,
                                  type: kStudent,
                                  model: data[index])),
                        ); */
                      }),
                      title: Column(
                        children: [
                          const Divider(
                            color: Colors.black,
                            height: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        textAlign: TextAlign.center,
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        '    ${data[index].trip_in_progress}',
                                        textAlign: TextAlign.center,
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        data[index].vehicle_in_queue!,
                                        textAlign: TextAlign.center,
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        data[index].completed_trips!,
                                        textAlign: TextAlign.center,
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        data[index].date!,
                                        textAlign: TextAlign.center,
                                      ))),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              error: (_, __) => const Text('An error occurred'),
              loading: () => const Center(child: CircularProgressIndicator())),
        ]));
  }
}
