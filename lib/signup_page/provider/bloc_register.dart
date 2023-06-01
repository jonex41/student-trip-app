import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:student_project/auth/helpers.dart';
import 'package:student_project/model/register_model.dart';
import 'package:student_project/utils/constants.dart';

import '../view/sign_up_screen.dart';

class RegisterFormBloc extends FormBloc<String, String> {
  // final ApiRepository _apiRepository;
  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final registrationNo = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final phone = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final address = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final department = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
   final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final doYouLikeFormBloc = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: ['Male', 'Female'],
  );
  final confirmPassword = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final facultyselect = SelectFieldBloc(
    items: allFaculty,
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final departmentSelect = SelectFieldBloc(
    items: <String>[],
    validators: [
      FieldBlocValidators.required,
    ],
  );
  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'password does not match';
    };
  }

  RegisterFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        name,
        registrationNo,
        phone,
        address,
        facultyselect, departmentSelect,
        doYouLikeFormBloc,
        email
        // password,
        // confirmPassword
      ],
    );
    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
    // return super(null);
  }

  @override
  void onSubmitting() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
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

        final model = RegisterModel(
            name: name.value,
            gender: doYouLikeFormBloc.value!,
            registrationNo: registrationNo.value,
            phone: phone.value,
            address: address.value,
            department: departmentSelect.value,
            password: '',
            vehicleId: '',
            urlImage:  getStringAsync('uploadImage'),
            count: '0',
            email:email.value,
            departmentId: deparmentId,
            personId: personId,
            staffId: '',
            studentId: studentId);

        FirebaseFirestore.instance
            .collection(kStudentBase)
            .doc(user!.uid)
            .set(model.toJson())
            .then((value) {
          FirebaseFirestore.instance
              .collection('generatingId')
              .doc('list')
              .set(<String, String>{
            kDepartmentId: newDeparmentId,
            kPersonId: newPersonId,
            kStudentId: newStudentId,
          }, SetOptions(merge: true));
          setValue(kState, kStudent);
          setValue(kNameReal, name.value);
          emitSuccess();
        }).catchError((error) => showSnackBar('Unable to add users'));

        log("could  $deparmentId $personId $staffId $studentId");
      }).catchError(() {
        emitFailure();
        log("could not get values");
      });
    } catch (e) {
      if (e == 'username-not-found') {
        emitFailure(failureResponse: 'Account does not exist!');
      } else {
        emitFailure(failureResponse: e.toString());
      }
    }
    //    emitFailure(failureResponse: 'This is an awesome error!');
  }

  String convertTONeeded(String mainWord, String otherWord) {
    String edit1 = mainWord.split(otherWord).last;
    int kkk = int.parse(edit1) + 1;
    return "${otherWord}00$kkk";
  }
}
