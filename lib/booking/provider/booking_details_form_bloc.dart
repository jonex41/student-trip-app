

import 'dart:io';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class BookingDetailsFormBloc extends FormBloc<String, String> {
 // final ApiRepository _apiRepository;
  final bookingRef = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  

  final from = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  
    final destination = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
   final departureDate = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

   final departureTime= TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
final selectedOperator= TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final noPassengers = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final bookingBy = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
 /*   final confirmPassword = TextFieldBloc(
    validators: [FieldBlocValidators.required],
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
  } */


  BookingDetailsFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        bookingRef,
        from,
        destination,
        departureDate,
        departureTime,
        noPassengers,
        selectedOperator,
        bookingBy
       
      ],
    );
    
    // return super(null);
  }
  

  @override
  void onSubmitting() async {
    try {



     /*  AuthResponse res = await _apiRepository.login(
          username: username.value, password: password.value); */

      if (true == true) {
       /*  setValue(kToken, res.data.token);
        setValue(kIsLoggedIn, true);
        setValue(kFullName, res.data.name);
        setValue(kUid, res.data.id);
        setValue(kEmail, res.data.email);

        setValue(kUserName, res.data.username);
        setValue(kUserPlaceId, res.data.placeId);
        setValue(kProfilePic, res.data.photo ?? ''); */
        emitSuccess(successResponse: "res");
      }
    } catch (e) {
      //  logger.d(e);
      //   print(' an error is occuring ohhh');
      /*    if (e is LogInWithEmailAndPasswordFailure) {
        emitFailure(failureResponse: e.message);
      } else */
      if (e == 'username-not-found') {
        emitFailure(failureResponse: 'Account does not exist!');
      } else {
        emitFailure(failureResponse: e.toString());
      }
    }
    //    emitFailure(failureResponse: 'This is an awesome error!');
  }
}
