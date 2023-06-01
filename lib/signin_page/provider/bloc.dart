

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class LoginFormBloc extends FormBloc<String, String> {
 // final ApiRepository _apiRepository;

  final username = TextFieldBloc(
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

  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        username,
        password,
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
