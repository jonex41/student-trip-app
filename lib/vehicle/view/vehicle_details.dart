import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/provider/admin_provider.dart';

class VehicleDetailsScreen extends ConsumerWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vehicleDtailsProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vehicle Details'),
        ),
        body: state.when(
            data: (data) => data != null
                ? ListView(
                    // horizontal).
                    padding: const EdgeInsets.all(15),
                    children: <Widget>[
                      10.height,
                      if (data.imageUrl != null)
                        CircleAvatar(
                          radius: 100.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              data.imageUrl!,
                            ),
                          ),
                        ),
                      10.height,
                      Row(
                        children: [
                          const Text(
                            'Date :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.date ?? 'Date',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          const Text(
                            'Driver Name :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.name!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Adddress :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.address!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Phone number :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.phoneNumber!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          const Text(
                            'Vehicles Reg. No. :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.ownderId!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      20.height,
                      /*  Row(
                        children: [
                          const Text(
                            'Vehicle Destination :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          const Text(
                            'Destination',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      20.height, */
                      Row(
                        children: [
                          const Text(
                            'no. of Vehicles Trip :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.count!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          const Text(
                            'Total Amount of Trip :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          Text(
                            data.count!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      /*  40.height,
                      Row(
                        children: [
                          const Text(
                            'Vehicle Destination :',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          10.width,
                          const Text(
                            '',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ), */
                      40.height,
                      /*  ElevatedButton(
                          onPressed: () {}, child: const Text('Print')) */
                    ],
                  )
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
                      const Text('Please create a vehicle first'),
                    ],
                  )),
            error: (_, __) => const Center(child: Text('An error occurred')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
