import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/utils/colors.dart';
import 'package:student_project/utils/loader.dart';

import '../../home/decision_page/view/decision_page.dart';
import '../../model/register_model.dart';
import '../../utils/constants.dart';
import 'edit_student_profile.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _phoneFieldController = TextEditingController();
  var name = '';
  var phone = '';

  Future<void> _displayTextInputDialog(BuildContext context,
      {String? name, String? phone, String? value, String? id}) async {
    _nameFieldController.text = name!;
    _phoneFieldController.text = phone!;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameFieldController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: _phoneFieldController,
                decoration: const InputDecoration(hintText: "phone"),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () async {
                showLoader(context);
                log('name   $value');
                log('id   $id');
                final map = {'phone': phone, 'name': name};
                await FirebaseFirestore.instance
                    .collection(value!)
                    .doc(id)
                    .set(map, SetOptions(merge: true))
                    .then((value) {
                  hideLoader();

                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  log('name   $error');
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final state = ref.watch(singleUserProvider);

    final user = FirebaseAuth.instance.currentUser;
    log('id user ${user!.uid}');
    String value = getStringAsync(kState);
    if (kStudent.toLowerCase().contains(value)) {
      value = kStudentBase;
    } else {
      value = kOperatorBase;
    }

    DocumentReference ref =
        FirebaseFirestore.instance.collection(value).doc(user.uid);
    return SafeArea(
        child: Scaffold(
            backgroundColor: scaffoldColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: (() {
                  context.pop();
                }),
                child: const Icon(
                  PhosphorIcons.caret_left,
                  color: Colors.black,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentEditScreen()),
                    );
                    /*  _displayTextInputDialog(context,
                        name: name, phone: phone, value: value, id: user.uid); */
                  },
                  child: const Icon(
                    PhosphorIcons.pencil_simple,
                    color: Colors.black,
                  ),
                ),
                15.width
              ],
            ),
            body: StreamBuilder<RegisterModel>(
              stream: ref.snapshots().map((event) =>
                  RegisterModel.fromJson(event.data() as Map<String, dynamic>)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RegisterModel data = snapshot.data!;
                  name = data.name!;
                  setValue(kName, name);
                  phone = data.phone!;
                  return Center(
                    child: ListView(
                      // padding: EdgeInsets.only(left: 20, right: 15),
                      children: <Widget>[
                        ListTile(
                          tileColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 20),
                          title: Text(
                            data.name!,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                          subtitle: Text(
                            data.phone!,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 25,
                            child: Image.network(
                              data.urlImage!,
                              width: 150.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            // Update the state of the app.
                            // ...
                          },
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Icon(PhosphorIcons.envelope_simple),
                              5.width,
                              Text(
                                data.email!,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Icon(PhosphorIcons.phone),
                              5.width,
                              Text(
                                data.phone!,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Icon(PhosphorIcons.person),
                              5.width,
                              Text(
                                data.gender!,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Icon(PhosphorIcons.address_book),
                              5.width,
                              Text(
                                data.address!,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        /*  Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favourite location',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                    ListTile(
                      minVerticalPadding: 0,
                      contentPadding: EdgeInsets.zero,
                      title: Align(
                        child: new Text("Home"),
                        alignment: Alignment(-1.2, 0),
                      ),
                      leading: Icon(Icons.home),
                      trailing: const Text('Add'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      minVerticalPadding: 0,
                      contentPadding: EdgeInsets.zero,
                      title: Align(
                        child: new Text("Work"),
                        alignment: Alignment(-1.2, 0),
                      ),
                      leading: Icon(PhosphorIcons.briefcase),
                      trailing: const Text('Add'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ),
              ),
              */
                        const Divider(),
                        /*     Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Communication prefrences',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            trailing: const Icon(PhosphorIcons.caret_right),
                          ),
                        ),
                        10.height, */
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (() async {
                                  await FirebaseAuth.instance.signOut();
                                  setValue(kState, "none");

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DecisionPage()),
                                  );
                                }),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/log_out.svg",
                                    ),
                                    const Text('Log out')
                                  ],
                                ),
                              ),
                              10.height,
                              GestureDetector(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  setValue(kState, "none");

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DecisionPage()),
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Icon(PhosphorIcons.trash),
                                    Text('Delete account')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Text("Something went wrong");
              },
            )));

    /*  state.when(
            data: (data) => data != null
                ?
                : const Center(child: Text('Could not load data')),
            error: (_, __) => const Center(child: Text('An error occurred')),
            loading: () => const Center(child: CircularProgressIndicator())),
      ), */
  }
}
