import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:student_project/admin/provider/admin_provider.dart';

import '../../../utils/constants.dart';
import '../../helpers.dart';

class OperatorBookingPage extends HookConsumerWidget
    with WidgetsBindingObserver {
  const OperatorBookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operatorBookingListProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking History '),
        ),
        body: state.when(
            data: (data) => data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ListTile(
                        minLeadingWidth: 0,
                        onTap: (() {
                          /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancelBookingPage(
                                  model: data[index],
                                )),
                      ); */
                        }),
                        leading: CircleAvatar(
                          radius: 16.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset('assets/images/logo.jpg'),
                          ),
                        ),
                        title: Align(
                            alignment: const Alignment(-1.1, 0),
                            child: Text(data[index].bookinRef!)),
                        subtitle: Row(
                          children: [
                            const Text('Des:'),
                            Text(
                              ' ${data[index].destination!}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              if (data[index].progress == kCompleted) {
                                showSnackBar('Trip Already completed');
                              }
                            },
                            child: Text(data[index].progress ?? 'Waiting')),
                      );
                    })
                : Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 100,
                        child: Image(
                          image: AssetImage("assets/images/logo.jpg"),
                        ),
                      ),
                      10.height,
                      const Text('No bookings yet'),
                    ],
                  )),
            error: (_, __) => const Center(child: Text('An error occurred')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
