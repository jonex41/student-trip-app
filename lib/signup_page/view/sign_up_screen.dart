import 'dart:io';

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
import 'package:student_project/signin_page/view/sign_screen.dart';
import 'package:student_project/signup_page/provider/bloc_register.dart';
import 'package:student_project/utils/app_button.dart';

import '../../student_home/view/student_home_screen.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';

final allFaculty = [
  'Faculty of Arts, Management and Social Sciences',
  'Faculty of Engineering',
  'Faculty of Law',
  'Faculty of Science',
  'School of Basic Medical Science',
  'School of Applied Health Science'
      'School of Medicine'
];
final artDepartment = [
  'Accounting'
      'Business Administration',
  'Economics',
  'English Language',
  'History and International Studies',
  'Mass Communication',
  'Political Science',
  'Banking and Finance',
  'Entrepreneurship ',
  'Peace and Conflict Studies  ',
  'Sociology',
  'Public Administration',
];
final engineeringDepartment = [
  'Chemical Engineering',
  'Civil Engineering',
  'Computer Engineering',
  'Electrical/Electronic Engineering',
  'Mechanical Engineering',
];
final lawDepartment = ['Law'];
final scienceDepartment = [
  'Biochemistry',
  'Industrial Chemistry',
  'Computer Science',
  'Mathematics',
  'Microbiology',
  'Animal and Environmental Biology',
  'Plant Biology and Biotechnology',
  'Physics with Electronics',
];
final bmedicalDepartment = [
  'Physiology',
  'Anatomy',
  'Biochemistry',
];

final aHealthDepartment = [
  'Medical Laboratory Science',
  'Nursing',
];
final medicineDepartment = ['Medicine and Surgery'];

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  List<String> getListDepartment(String value) {
    if (value == allFaculty[0]) {
      return artDepartment;
    } else if (value == allFaculty[1]) {
      return engineeringDepartment;
    } else if (value == allFaculty[2]) {
      return lawDepartment;
    } else if (value == allFaculty[3]) {
      return scienceDepartment;
    } else if (value == allFaculty[4]) {
      return bmedicalDepartment;
    } else if (value == allFaculty[5]) {
      return aHealthDepartment;
    } else if (value == allFaculty[6]) {
      return medicineDepartment;
    }
    return artDepartment;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = useState('');
    final uploadurl = useState('');
    final isLoading = useState(false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Student/User Register",
            style: GoogleFonts.poppins(
                color: black,
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: BlocProvider(
          create: (context) => RegisterFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<RegisterFormBloc>();
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  body: SafeArea(
                child: FormBlocListener<RegisterFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    showLoader(context);
                  },
                  onSuccess: (context, state) {
                    hideLoader();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentHomePage()),
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
                              child: url.value.isEmptyOrNull
                                  ? const Icon(
                                      PhosphorIcons.plus_circle,
                                      size: 50,
                                    )
                                  : isLoading.value
                                      ? const Center(
                                          child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              )))
                                      : Image.network(
                                          url.value,
                                        ),
                            ),
                          ),
                        ),

                        /*   GestureDetector(
                          onTap: () async {
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
                          },
                          child: CircleAvatar(
                            radius: 100.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: url.value.isEmptyOrNull
                                  ? const Icon(PhosphorIcons.plus_circle, size: 50,)
                                  : Image.network(
                                      url.value,
                                    ),
                            ),
                          ),
                        ),
                        */
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.name,
                          decoration: inputDecoration(
                              labelText: 'Full name.',
                              prefixIcon: const Icon(PhosphorIcons.user)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.registrationNo,
                          decoration: inputDecoration(
                              labelText: 'Registration No.',
                              prefixIcon: const Icon(PhosphorIcons.user)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.phone,
                          decoration: inputDecoration(
                              labelText: 'Phone',
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
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: loginFormBloc.facultyselect,
                          onChanged: (value) {
                            loginFormBloc.departmentSelect
                                .updateItems(getListDepartment(value!));
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Faculty',
                            prefixIcon: Icon(Icons.sentiment_satisfied),
                          ),
                          itemBuilder: (context, value) => FieldItem(
                            child: Text(value),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: loginFormBloc.departmentSelect,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            labelText: 'Select Department',
                            prefixIcon: Icon(Icons.sentiment_satisfied),
                          ),
                          itemBuilder: (context, value) => FieldItem(
                            child: Text(value),
                          ),
                        ),
                        /* TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.department,
                          decoration: inputDecoration(
                              labelText: 'Department',
                              prefixIcon:
                                  Icon(PhosphorIcons.address_book_fill)),
                        ), */
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

                        BlocBuilder<RegisterFormBloc, FormBlocState>(
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
