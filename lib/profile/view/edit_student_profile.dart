import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:student_project/utils/app_button.dart';

import '../../model/register_model.dart';
import '../../student_home/view/student_home_screen.dart';
import '../../utils/constants.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';
import 'edit_student_bloc.dart';

class StudentEditScreen extends HookConsumerWidget {
  StudentEditScreen({super.key});
  var url = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadurl = useState('');
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
        appBar: AppBar(
          title: Text(
             "Edit Profile",
            style: GoogleFonts.poppins(
                color: black,
                textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: StreamBuilder<RegisterModel>(
            stream: ref.snapshots().map((event) =>
                RegisterModel.fromJson(event.data() as Map<String, dynamic>)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RegisterModel data = snapshot.data!;
                return BlocProvider(
                  create: (context) => StudentEditFormBloc(),
                  child: Builder(builder: (context) {
                    final loginFormBloc = context.read<StudentEditFormBloc>();
                    /*  name,
        registrationNo,
        phone,
        address,
        
       
        email */
                    loginFormBloc.name.updateValue(data.name!);
                    loginFormBloc.email.updateValue(data.email!);
                    loginFormBloc.address.updateValue(data.address!);
                    loginFormBloc.registrationNo
                        .updateValue(data.registrationNo!);
                    loginFormBloc.phone.updateValue(data.phone!);
                    url = data.urlImage!;
                    uploadurl.value = url;
                    return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Scaffold(
                          body: SafeArea(
                        child: FormBlocListener<StudentEditFormBloc, String,
                            String>(
                          onSubmitting: (context, state) {
                            showLoader(context);
                          },
                          onSuccess: (context, state) {
                            hideLoader();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StudentHomePage()),
                            );

                            //context.router.replaceAll([DashboardRoute()]);
                          },
                          onFailure: (context, state) {
                            //   print('failure ${state.failureResponse!}');
                            //   LoadingDialog.hide(context);
                            hideLoader();
                            snackBar(context,
                                title: state.failureResponse!,
                                backgroundColor: Colors.red);
                          },
                          child: AutofillGroup(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 24.0),
                              children: [
                                20.height,
                                /*  Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.poppins(
                                    color: black,
                                    textStyle: TextStyle(
                                        fontSize: 28, fontWeight: FontWeight.w700)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter your details correctly',
                                style: GoogleFonts.poppins(
                                    color: gray,
                                    textStyle: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w400)),
                              ),
                            ),
                            25.height, */
                                GestureDetector(
                                  onTap: () async {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    FirebaseStorage storage =
                                        FirebaseStorage.instance;
                                    final ImagePicker picker = ImagePicker();
                                    // Pick an image
                                    final XFile? pickedFile = await picker
                                        .pickImage(source: ImageSource.gallery);

                                    File image;
                                    if (pickedFile != null) {
                                      image = File(pickedFile.path);
                                    } else {
                                      print('No image selected.');
                                      return;
                                    }
                                    Reference reference = FirebaseStorage
                                        .instance
                                        .ref()
                                        .child('profileImage/${user!.uid}');
                                    UploadTask uploadTask =
                                        reference.putFile(image);
                                    TaskSnapshot snapshot = await uploadTask;
                                    uploadurl.value =
                                        await snapshot.ref.getDownloadURL();
                                    url = uploadurl.value;
                                    setValue('uploadImage', uploadurl.value);
                                  },
                                  child: CircleAvatar(
                                    radius: 80.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(
                                        url,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: loginFormBloc.name,
                                  decoration: inputDecoration(
                                      labelText: 'Full name.',
                                      prefixIcon:
                                          const Icon(PhosphorIcons.user)),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: loginFormBloc.registrationNo,
                                  decoration: inputDecoration(
                                      labelText: 'Registration No.',
                                      prefixIcon:
                                          const Icon(PhosphorIcons.user)),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: loginFormBloc.phone,
                                  decoration: inputDecoration(
                                      labelText: 'Phone',
                                      prefixIcon:
                                          const Icon(PhosphorIcons.phone)),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: loginFormBloc.address,
                                  decoration: inputDecoration(
                                      labelText: 'Address',
                                      prefixIcon: const Icon(
                                          PhosphorIcons.address_book)),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: loginFormBloc.email,
                                  decoration: inputDecoration(
                                      labelText: 'email',
                                      prefixIcon:
                                          const Icon(PhosphorIcons.cards)),
                                ),

                                /* TextFieldBlocBuilder(
                              textFieldBloc: loginFormBloc.department,
                              decoration: inputDecoration(
                                  labelText: 'Department',
                                  prefixIcon:
                                      Icon(PhosphorIcons.address_book_fill)),
                            ), */

                                /*Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text('Forgot Password?'),
                          onPressed: () => null,
                        )
                      ],
                    ), */

                                BlocBuilder<StudentEditFormBloc, FormBlocState>(
                                  bloc: loginFormBloc,
                                  builder: (context, FormBlocState state) {
                                    return AppButton(
                                      title: 'Edit',
                                      onPressed: () {
                                        if (uploadurl.value.isEmptyOrNull) {
                                          snackBar(context,
                                              title: 'Please select an image',
                                              backgroundColor: Colors.red);
                                          return;
                                        }
                                        loginFormBloc.submit();
                                      },
                                      isDisabled:
                                          state.isValid(0) ? false : true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                    );
                  }),
                );
              }
              return const Text("Something went wrong");
            }),
      ),
    );
  }
}
