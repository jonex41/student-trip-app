import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:student_project/signin_page/provider/bloc.dart';
import 'package:student_project/signin_page/view/sign_screen.dart';
import 'package:student_project/signup_page/provider/bloc_register.dart';
import 'package:student_project/utils/app_button.dart';
import 'package:student_project/utils/constants.dart';

import '../../sign_in_operator/provider/operator_form_bloc.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';
import '../provider/create_vehicle_form_bloc.dart';

class CreateVehicleScreen extends HookConsumerWidget {
  const CreateVehicleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = useState('');
    final uploadurl = useState('');
    final isLoading = useState(false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Vehicle",
            style: GoogleFonts.poppins(
                color: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: BlocProvider(
          create: (context) => VehicleFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<VehicleFormBloc>();
            final user = FirebaseAuth.instance.currentUser;
            FirebaseFirestore.instance
                .collection(kOperatorBase)
                .doc(user!.uid)
                .get()
                .then((value) {
              String deparmentId = value.data()![kDepartmentId];
              String personId = value.data()![kPersonId];
              String staffId = value.data()![kStaffId];
              String studentId = value.data()![kStudentId];

              loginFormBloc.id.updateValue(personId);
              //loginFormBloc.personId.updateValue(personId);
            });
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  body: SafeArea(
                child: FormBlocListener<VehicleFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    showLoader(context);
                  },
                  onSuccess: (context, state) {
                    snackBar(context,
                        title: 'Vehicle created successfully',
                        backgroundColor: Colors.green);
                    hideLoader();
                    context.pop();

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
                                .child('VehicleImage/${user!.uid}');
                            UploadTask uploadTask = reference.putFile(image);
                            TaskSnapshot snapshot = await uploadTask;
                            uploadurl.value =
                                await snapshot.ref.getDownloadURL();
                            url.value = uploadurl.value;
                            setValue('vehicleImage', uploadurl.value);
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
                                      size: 100,
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
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.id,
                          decoration: inputDecoration(
                              labelText: 'ID',
                              prefixIcon: const Icon(PhosphorIcons.user)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.ownerId,
                          decoration: inputDecoration(
                              labelText: 'Owner ID',
                              prefixIcon:
                                  const Icon(PhosphorIcons.user_circle)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.name,
                          decoration: inputDecoration(
                              labelText: 'Name',
                              prefixIcon:
                                  const Icon(PhosphorIcons.person_simple_bold)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.phoneNumber,
                          decoration: inputDecoration(
                              labelText: 'Phone number',
                              prefixIcon: const Icon(PhosphorIcons.phone)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.model,
                          decoration: inputDecoration(
                              labelText: 'Model',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book_fill)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.type,
                          decoration: inputDecoration(
                              labelText: 'Type',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book_fill)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.plate_number,
                          decoration: inputDecoration(
                              labelText: 'Plate Number',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book_fill)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.capacity,
                          decoration: inputDecoration(
                              labelText: 'Capacity',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book_fill)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.address,
                          decoration: inputDecoration(
                              labelText: 'Address',
                              prefixIcon:
                                  const Icon(PhosphorIcons.address_book)),
                        ),

                        /*Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Forgot Password?'),
                      onPressed: () => null,
                    )
                  ],
                ), */

                        BlocBuilder<VehicleFormBloc, FormBlocState>(
                          bloc: loginFormBloc,
                          builder: (context, FormBlocState state) {
                            return AppButton(
                              title: 'Submit',
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
                        /*   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('have an account yet?',
                                style: TextStyle(fontSize: 16.0)),
                            TextButton(
                                onPressed: () {
                                  //context.replaceRoute(SignupRoute());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()),
                                  );
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 16.0),
                                ))
                          ],
                        )
                      */
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
