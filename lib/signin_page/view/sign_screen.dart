import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:student_project/home/decision_page/provider/decision_provider.dart';
import 'package:student_project/home/view/home_screen.dart';
import 'package:student_project/sign_in_operator/view/sign_in_operator.dart';
import 'package:student_project/utils/app_button.dart';
import 'package:student_project/utils/constants.dart';

import '../../reset_password/view/reset_screen.dart';
import '../../signup_page/view/sign_up_screen.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';
import '../provider/bloc.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final state = ref.watch(providerState);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<LoginFormBloc>();
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Sign in",
                      style: GoogleFonts.poppins(
                          color: black,
                          textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ),
                  body: SafeArea(
                    child: FormBlocListener<LoginFormBloc, String, String>(
                      onSubmitting: (context, state) {
                        showLoader(context);
                      },
                      onSuccess: (context, state) {
                        hideLoader();
                        final type = ref.read(decisionProvider);
                        if (type == kStudent) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }

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
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 24.0),
                          children: [
                            20.height,
                            /*  Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Sign in',
                                style: GoogleFonts.poppins(
                                    color: black,
                                    textStyle: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ), */
                            /*  Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Welcome back you’ve been missed',
                                style: GoogleFonts.poppins(
                                    color: gray,
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            45.height, */
                            TextFieldBlocBuilder(
                              textFieldBloc: loginFormBloc.username,
                              decoration: inputDecoration(
                                  labelText: 'Email/Username',
                                  prefixIcon: Icon(PhosphorIcons.user)),
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: loginFormBloc.password,
                              suffixButton: SuffixButton.obscureText,
                              obscureTextFalseIcon: Icon(PhosphorIcons.eye),
                              obscureTextTrueIcon:
                                  Icon(PhosphorIcons.eye_slash),
                              decoration: inputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(PhosphorIcons.lock),
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
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResetPasswordScreen()),
                                  );
                                }),
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.poppins(
                                      color: gray,
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ),
                            40.height,
                            BlocBuilder<LoginFormBloc, FormBlocState>(
                              bloc: loginFormBloc,
                              builder: (context, FormBlocState state) {
                                return AppButton(
                                  title: 'Login',
                                  onPressed: loginFormBloc.submit,
                                  isDisabled: state.isValid(0) ? false : true,
                                );
                              },
                            ),
                            24.height,
                            Row(children: <Widget>[
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 25.0, right: 20.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                              Text("OR"),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 25.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            20.height,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: gray),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/images/twitter.svg",
                                  ),
                                ),
                                20.width,
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: gray),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/images/facebook_icon.svg",
                                  ),
                                ),
                                20.width,
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: gray),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/images/google_icon.svg",
                                  ),
                                )
                              ],
                            ),
                            20.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account yet?',
                                    style: TextStyle(fontSize: 16.0)),
                                TextButton(
                                    onPressed: () {
                                      //context.replaceRoute(SignupRoute());
                                      final type = ref.read(decisionProvider);
                                      if (type == kStudent) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen()),
                                        );
                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OperatorSignUpScreen()),
                                        );
                                      }

                                      /*   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()),
                                      ); */
                                    },
                                    child: Text(
                                      'Sign up',
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
