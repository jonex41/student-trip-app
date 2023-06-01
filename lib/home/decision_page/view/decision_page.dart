import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_project/admin/view/admin_page.dart';
import 'package:student_project/auth/authentication_screen.dart';
import 'package:student_project/home/decision_page/provider/decision_provider.dart';
import 'package:student_project/utils/constants.dart';

import '../../../gallery/view/gallery.dart';

class DecisionPage extends ConsumerStatefulWidget {
  const DecisionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DecisionPageState();
}

class _DecisionPageState extends ConsumerState<ConsumerStatefulWidget> {
  final TextEditingController _controller = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');

  final snackBar = const SnackBar(
    content: Text('Wrong Password'),
  );

  final _myValue = false;

  Future showBottomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              'Admin only',
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: 'Enter Password'),
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty || value != 'admin') {
                        return 'Enter right password';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      if (val.length > 3) {
                        /* setState(() {
                          _myValue = true;
                        });*/
                      }
                    },
                  ),
                  Visibility(
                      visible: _myValue,
                      child: const Text(
                        'Wrong password!!',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // await widget.addMessage(_controller.text);

                    Navigator.of(context).pop();
                    setValue(kState, kAdmin);
                    await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const AdminPage()));
                    // setState(() {});
                    //_controller.clear();
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ));

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  void askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Campus Transit'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*  SizedBox(
            height: 50,
            child: const Image(
              image: AssetImage("assets/images/logo.jpg"),
            ),
          ), */

          Row(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  ref.read(decisionProvider.notifier).state = kStudent;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationScreen()),
                  );
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/images/student_1.jpg',
                            width: 150.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          padding: const EdgeInsets.all(12),
                          child: const Text("Student",
                              style: TextStyle(color: white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              10.width,
              InkWell(
                onTap: () {
                  ref.read(decisionProvider.notifier).state = kOperator;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationScreen()),
                  );
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/images/vehicle_1.jpg',
                            width: 150.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            "Operator",
                            style: TextStyle(color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              /*  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child:
                          Icon(Icons.person, size: 24, color: Colors.blueAccent),
                      padding: const EdgeInsets.all(12),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Text("Student"),
                      padding: const EdgeInsets.all(12),
                    )
                  ],
                ),
              ),
              10.width,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child:
                          Icon(Icons.person, size: 24, color: Colors.blueAccent),
                      padding: const EdgeInsets.all(12),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Text("Student"),
                      padding: const EdgeInsets.all(12),
                    )
                  ],
                ),
              )
 */
              /*  InkWell(
                onTap: () {
                   ref.read(decisionProvider.notifier).state = kStudent;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                  // print('button Pressed');
                  // Call your onPressed or onTap function here
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 200,
                  width: 150,
                  child: const Text(
                    'Student',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              10.width,
              InkWell(
                onTap: () {
                  ref.read(decisionProvider.notifier).state = kOperator;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 200,
                  width: 150,
                  child: const Text(
                    'Operator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
             */
            ],
          ),
          15.height,
          Row(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  //  ref.read(decisionProvider.notifier).state = kStudent;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GalleryPage()),
                  );
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/images/gallery.jpg',
                            width: 150.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          padding: const EdgeInsets.all(12),
                          child: const Text("Gallary",
                              style: TextStyle(color: white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              10.width,
              InkWell(
                onTap: () {
                  // ref.read(decisionProvider.notifier).state = kStudent;
                  showBottomDialog(context);
                  /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ),
                  ); */
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/images/admin_1.jpg',
                            width: 150.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          padding: const EdgeInsets.all(12),
                          child: const Text("Admin",
                              style: TextStyle(color: white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              /*  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child:
                          Icon(Icons.person, size: 24, color: Colors.blueAccent),
                      padding: const EdgeInsets.all(12),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Text("Student"),
                      padding: const EdgeInsets.all(12),
                    )
                  ],
                ),
              ),
              10.width,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child:
                          Icon(Icons.person, size: 24, color: Colors.blueAccent),
                      padding: const EdgeInsets.all(12),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Text("Student"),
                      padding: const EdgeInsets.all(12),
                    )
                  ],
                ),
              )
 */
              /*  InkWell(
                onTap: () {
                   ref.read(decisionProvider.notifier).state = kStudent;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                  // print('button Pressed');
                  // Call your onPressed or onTap function here
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 200,
                  width: 150,
                  child: const Text(
                    'Student',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              10.width,
              InkWell(
                onTap: () {
                  ref.read(decisionProvider.notifier).state = kOperator;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 200,
                  width: 150,
                  child: const Text(
                    'Operator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
             */
            ],
          ),
        ],
      ),
    );
  }
}
