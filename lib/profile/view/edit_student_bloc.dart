import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:student_project/auth/helpers.dart';
import 'package:student_project/utils/constants.dart';

class StudentEditFormBloc extends FormBloc<String, String> {
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
/*   final doYouLikeFormBloc = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: ['Male', 'Female'],
  );
  final confirmPassword = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  ); */

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

  StudentEditFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        name,
        registrationNo,
        phone,
        address,

        email
        // password,
        // confirmPassword
      ],
    );
    /* confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]); */
    // return super(null);
  }

  @override
  void onSubmitting() async {
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
    try {
      final model = <String, dynamic>{
        'name': name.value,
        'registrationNo': registrationNo.value,
        'phone': phone.value,
        'address': address.value,
        'urlImage': getStringAsync('uploadImage'),
        'email': email.value,
      };

      ref.set(model, SetOptions(merge: true)).then((value) {
        emitSuccess();
      }).catchError((error) => showSnackBar('Unable to add users'));
    } catch (e) {}
    // log("could  $deparmentId $personId $staffId $studentId");

    //    emitFailure(failureResponse: 'This is an awesome error!');
  }

  String convertTONeeded(String mainWord, String otherWord) {
    String edit1 = mainWord.split(otherWord).last;
    int kkk = int.parse(edit1) + 1;
    return "${otherWord}00$kkk";
  }
}
