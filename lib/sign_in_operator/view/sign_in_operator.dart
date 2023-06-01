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
import 'package:student_project/auth/operator_home/view/home_operator.dart';
import 'package:student_project/signin_page/view/sign_screen.dart';
import 'package:student_project/utils/app_button.dart';

import '../../utils/constants.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';
import '../provider/operator_form_bloc.dart';

class OperatorSignUpScreen extends HookConsumerWidget {
  const OperatorSignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = useState('');
    final uploadurl = useState('');
    final isLoading = useState(false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Operator Register",
            style: GoogleFonts.poppins(
                color: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: BlocProvider(
          create: (context) => OperatorFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<OperatorFormBloc>();
            FirebaseFirestore.instance
                .collection('generatingId')
                .doc('list')
                .get()
                .then((value) {
              String deparmentId = value.data()![kDepartmentId];
              String personId = value.data()![kPersonId];
              String staffId = value.data()![kStaffId];
              String studentId = value.data()![kStudentId];
              String newDeparmentId = convertTONeeded(deparmentId, "EDSUDPID");
              String newPersonId = convertTONeeded(personId, "EDSUPNID");
              String newStaffId = convertTONeeded(staffId, "EDSUSFID");
              String newStudentId = convertTONeeded(studentId, "EDSUSID");
              loginFormBloc.operatorId.updateValue(newStaffId);
              loginFormBloc.personId.updateValue(personId);
            });
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  body: SafeArea(
                child: FormBlocListener<OperatorFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    showLoader(context);
                  },
                  onSuccess: (context, state) {
                    hideLoader();
                    setValue(kState, kOperator);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OperatorHomePage()),
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
                            isLoading.value = true;
                            final user = FirebaseAuth.instance.currentUser;
                            FirebaseStorage storage = FirebaseStorage.instance;
                            final ImagePicker picker = ImagePicker();
                            // Pick an image
                            final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);

                            File image;
                            if (pickedFile != null) {
                              image = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                              return;
                            }

                            Reference reference = FirebaseStorage.instance
                                .ref()
                                .child('profileImage/${user!.uid}');
                            UploadTask uploadTask = reference.putFile(image);
                            TaskSnapshot snapshot = await uploadTask;
                            uploadurl.value =
                                await snapshot.ref.getDownloadURL();
                            url.value = uploadurl.value;
                            setValue('uploadImage', uploadurl.value);
                            await Future.delayed(const Duration(seconds: 2),
                                () {
                              isLoading.value = false;
                            });
                          },
                          child: CircleAvatar(
                            radius: 100.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: isLoading.value
                                  ? const Center(
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          )))
                                  : url.value.isEmptyOrNull
                                      ? const Icon(
                                          PhosphorIcons.plus_circle,
                                          size: 100,
                                        )
                                      : Image.network(
                                          url.value,
                                        ),
                            ),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.name,
                          decoration: inputDecoration(
                              labelText: 'Full name',
                              prefixIcon: const Icon(PhosphorIcons.user)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.operatorId,
                          isEnabled: false,
                          decoration: inputDecoration(
                              labelText: 'Operator Id',
                              prefixIcon: const Icon(PhosphorIcons.user)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.regName,
                          decoration: inputDecoration(
                              labelText: 'Reg. Name',
                              prefixIcon: const Icon(PhosphorIcons.phone)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.personId,
                          isEnabled: false,
                          decoration: inputDecoration(
                              labelText: 'Person Id',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.phonenumber,
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration(
                              labelText: 'Phone numder',
                              prefixIcon: const Icon(PhosphorIcons.phone)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.address,
                          decoration: inputDecoration(
                              labelText: 'Address',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.email,
                          decoration: inputDecoration(
                              labelText: 'email',
                              prefixIcon: const Icon(PhosphorIcons.cards)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.operatorStatus,
                          decoration: inputDecoration(
                              labelText: 'Operator Status',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book_fill)),
                        ),
                        const Text("Gender"),
                        RadioButtonGroupFieldBlocBuilder(
                          padding: EdgeInsets.zero,
                          selectFieldBloc: loginFormBloc.doYouLikeFormBloc,
                          itemBuilder: (context, dynamic value) =>
                              FieldItem(child: Text(value)),
                          decoration: const InputDecoration(),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.password,
                          suffixButton: SuffixButton.obscureText,
                          obscureTextFalseIcon: const Icon(PhosphorIcons.eye),
                          obscureTextTrueIcon:
                              const Icon(PhosphorIcons.eye_slash),
                          decoration: inputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(PhosphorIcons.lock),
                            //     suffixIcon: Icon(PhosphorIcons.eyeSlash),
                          ),
                        ),
                        5.height,
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.confirmPassword,
                          suffixButton: SuffixButton.obscureText,
                          obscureTextFalseIcon: const Icon(PhosphorIcons.eye),
                          obscureTextTrueIcon:
                              const Icon(PhosphorIcons.eye_slash),
                          decoration: inputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(PhosphorIcons.lock),
                            //     suffixIcon: Icon(PhosphorIcons.eyeSlash),
                          ),
                        ),
                        5.height,
                        /*Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Forgot Password?'),
                      onPressed: () => null,
                    )
                  ],
                ), */

                        BlocBuilder<OperatorFormBloc, FormBlocState>(
                          bloc: loginFormBloc,
                          builder: (context, FormBlocState state) {
                            return AppButton(
                              title: 'Register',
                              onPressed: () {
                                if (uploadurl.value.isEmptyOrNull) {
                                  snackBar(context,
                                      title: 'Please select an image',
                                      backgroundColor: Colors.red);
                                  return;
                                }
                                loginFormBloc.submit();
                              },
                              isDisabled: state.isValid(0) ? false : true,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('have an account yet?',
                                style: TextStyle(fontSize: 16.0)),
                            TextButton(
                                onPressed: () {
                                  //context.replaceRoute(SignupRoute());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInPage()),
                                  );
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 16.0),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
            );
          }),
        ),
      ),
    );
  }
}
