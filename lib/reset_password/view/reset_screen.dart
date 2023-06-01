import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:student_project/reset_password/provider/bloc.dart';
import 'package:student_project/reset_password/view/confrim_email.dart';
import 'package:student_project/utils/app_button.dart';
import 'package:student_project/utils/loader.dart';

import '../../signin_page/provider/bloc.dart';
import '../../utils/input_decoration.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final state = ref.watch(providerState);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => ResetFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<ResetFormBloc>();
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  body: SafeArea(
                child: FormBlocListener<ResetFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    showLoader(context);
                  },
                  onSuccess: (context, state) {
                    hideLoader();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfirmScreen()),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      children: [
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (() {
                                context.pop();
                              }),
                              child: Row(
                                children: [
                                  Icon(PhosphorIcons.caret_left),
                                  5.width,
                                  Text(
                                    'Back',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            ),
                            Icon(PhosphorIcons.question),
                          ],
                        ),
                        29.height,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Reset password',
                            style: GoogleFonts.poppins(
                                color: black,
                                textStyle: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter the email associated with your account and we,ll send an email with instructions to reset your password ',
                            style: GoogleFonts.poppins(
                                color: gray,
                                textStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                          ),
                        ),
                        45.height,
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.email,
                          decoration: inputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(PhosphorIcons.user)),
                        ),
                        41.height,
                        BlocBuilder<ResetFormBloc, FormBlocState>(
                          bloc: loginFormBloc,
                          builder: (context, FormBlocState state) {
                            return AppButton(
                              title: 'Send instructions',
                              onPressed: loginFormBloc.submit,
                              isDisabled: state.isValid(0) ? false : true,
                            );
                          },
                        ),
                        24.height,
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
