import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:student_project/auth/helpers.dart';

import '../../model/register_model.dart';
import '../../utils/constants.dart';

class OperatorFormBloc extends FormBloc<String, String> {
  // final ApiRepository _apiRepository;
  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final operatorId = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final regName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final personId = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final operatorStatus = TextFieldBloc(
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

  final phonenumber = TextFieldBloc(
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

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final confirmPassword = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final doYouLikeFormBloc = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: ['Male', 'Female'],
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

  OperatorFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        name,
        operatorId,
        regName,
        personId,
        operatorStatus,
        phonenumber,
        address,
        
        // password,
        // confirmPassword,
        doYouLikeFormBloc,
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
        /* String deparmentId = value.data()![kDepartmentId];
        String personId = value.data()![kPersonId];
        String staffId = value.data()![kStaffId];
        String studentId = value.data()![kStudentId];
        String newDeparmentId = convertTONeeded(deparmentId, "EDSUDPID");
        String newPersonId = convertTONeeded(personId, "EDSUPNID");
        String newStaffId = convertTONeeded(staffId, "EDSUSFID");
        String newStudentId = convertTONeeded(studentId, "EDSUSID"); */
        String personIdw = value.data()![kPersonId];
        String staffId = value.data()![kStaffId];
        String newPersonId = convertTONeeded(personIdw, "EDSUPNID");
        String newStaffId = convertTONeeded(staffId, "EDSUSFID");

        final model = RegisterModel(
            name: name.value,
            gender: doYouLikeFormBloc.value!,
            registrationNo: '',
            phone: phonenumber.value,
            address: address.value,
            department: '',
            password: '',
            departmentId: '',
            count: '0',
            email: email.value,
            urlImage:  getStringAsync('uploadImage'),
            personId: personId.value,
            staffId: operatorId.value,
            vehicleId: '',
            studentId: '');

        FirebaseFirestore.instance
            .collection(kOperatorBase)
            .doc(user!.uid)
            .set(model.toJson())
            .then((value) {
          FirebaseFirestore.instance.collection('generatingId').doc('list').set(
              <String, String>{kPersonId: personIdw, kStaffId: newStaffId},
              SetOptions(merge: true));
           setValue(kState, kOperator);
           
          emitSuccess();
        }).catchError((error) => showSnackBar('Unable to add users'));

        //log("could  $deparmentId $personId $staffId $studentId");
      }).catchError(() {
        emitFailure();
        log("could not get values");
      });
    } catch (e) {
     
    }
    //    emitFailure(failureResponse: 'This is an awesome error!');
  }
}

String convertTONeeded(String mainWord, String otherWord) {
  String edit1 = mainWord.split(otherWord).last;
  int kkk = int.parse(edit1) + 1;

  return otherWord + "00" + kkk.toString();
}
