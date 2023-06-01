import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/provider/admin_provider.dart';

class TicketDetails extends HookConsumerWidget {
  const TicketDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generalbookingListProvider);
    final controller = useTextEditingController();
    final selectedDropdown = useState('Week');
    final searchText = useState('');
    final totalAmount = useState(0);
    var totalAmountw = 0;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tickets Details'),
        ),
        body: ListView(children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: const InputDecoration(label: Text('Search....')),
                  controller: controller,
                  onChanged: (value) {
                    totalAmountw = 0;
                    // ref.read(countProvider.notifier).update((state) => 0);
                    searchText.value = value ?? '';
                  },
                ),
              ),
              Expanded(
                  child: SizedBox(
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Name",
                    ),
                    value: selectedDropdown.value,
                    items: const [
                      DropdownMenuItem(value: 'Week', child: Text('Week')),
                      DropdownMenuItem(value: 'Month', child: Text('Month')),
                      DropdownMenuItem(value: 'Year', child: Text('Year'))
                    ],
                    onChanged: (value) {
                      selectedDropdown.value = value!;
                    }),
              ))
            ],
          ),
          10.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
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
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // red as border color
                  ),
                ),
                child: const Text(
                  'Ticket Id',
                  textAlign: TextAlign.center,
                ),
              )),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // red as border color
                  ),
                ),
                child: const Text(
                  'Status',
                  textAlign: TextAlign.center,
                ),
              )),
            ],
          ),
          if (searchText.value.isEmptyOrNull)
            state.when(
                data: (data) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      totalAmountw +=
                          int.parse(data[index].noPassenger.toString()) * 100;
                      if (data[index] == data.last) {
                        Future.delayed(const Duration(seconds: 3), () {
                          totalAmount.value = totalAmountw;
                        });
                      }
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
                        title: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Colors.white, // red as border color
                                      ),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Colors.white, // red as border color
                                      ),
                                    ),
                                    child: Text(
                                      '    ${data[index].bookinRef!}',
                                      textAlign: TextAlign.center,
                                    ))),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Colors.white, // red as border color
                                      ),
                                    ),
                                    child: Text(
                                      data[index].progress!,
                                      textAlign: TextAlign.center,
                                    ))),
                          ],
                        ),
                      );
                    }),
                error: (_, __) => const Text('An error occurred'),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          if (searchText.value.isNotEmpty)
            state.when(
                data: (data) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (data[index]
                              .bookinRef!
                              .toLowerCase()
                              .contains(searchText.value.toLowerCase()) ||
                          data[index]
                              .progress!
                              .toLowerCase()
                              .contains(searchText.value.toLowerCase())) {
                        totalAmountw +=
                            int.parse(data[index].noPassenger.toString()) * 100;
                        if (data[index] == data.last) {
                          Future.delayed(const Duration(seconds: 3), () {
                            totalAmount.value = totalAmountw;
                          });
                        }

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
                          title: Row(
                            children: [
                              Expanded(
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
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        '    ${data[index].bookinRef!}',
                                        textAlign: TextAlign.center,
                                      ))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .white, // red as border color
                                        ),
                                      ),
                                      child: Text(
                                        data[index].progress!,
                                        textAlign: TextAlign.center,
                                      ))),
                            ],
                          ),
                        );
                      }
                      return Container();
                    }),
                error: (_, __) => const Text('An error occurred'),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text('Amount : N${totalAmount.value}'),
          )
        ]));
  }
}
