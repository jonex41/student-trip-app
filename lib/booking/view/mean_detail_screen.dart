import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:student_project/booking/view/pdf_booking_details.dart';
import 'package:student_project/utils/app_button.dart';

import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';
import '../provider/booking_details_form_bloc.dart';
import '../provider/booking_provider.dart';

class MainDetailScreen extends HookConsumerWidget {
  const MainDetailScreen({
    super.key,
  });
  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.popUntil(context, (route) => route.settings.name == "/student");
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(bookingDetailsProvider.notifier).state;
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Booking Details",
              style: GoogleFonts.poppins(
                  color: black,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          body: BlocProvider(
            create: (context) => BookingDetailsFormBloc(),
            child: Builder(builder: (context) {
              final loginFormBloc = context.read<BookingDetailsFormBloc>();
              loginFormBloc.from.updateInitialValue(model.source!);
              //loginFormBloc..updateInitialValue(model.source!);
              loginFormBloc.bookingRef.updateInitialValue(model.bookinRef!);
              loginFormBloc.destination.updateInitialValue(model.destination!);
              loginFormBloc.departureDate
                  .updateInitialValue(model.departureDate!);
              loginFormBloc.departureTime
                  .updateInitialValue(model.departureTime!);
              loginFormBloc.bookingBy.updateInitialValue(model.studentName!);
              loginFormBloc.noPassengers
                  .updateInitialValue(model.noPassenger.toString());
              loginFormBloc.selectedOperator
                  .updateInitialValue(model.driverName!.toString());

              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                    body: SafeArea(
                  child:
                      FormBlocListener<BookingDetailsFormBloc, String, String>(
                    onSubmitting: (context, state) {
                      showLoader(context);
                    },
                    onSuccess: (context, state) {
                      hideLoader();

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
                          TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.bookingRef,
                            readOnly: true,
                            decoration: inputDecoration(
                                labelText: 'Booking Reference',
                                prefixIcon: const Icon(
                                    PhosphorIcons.chalkboard_teacher)),
                          ),
                          TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.from,
                            readOnly: true,
                            decoration: inputDecoration(
                                labelText: 'From',
                                prefixIcon: const Icon(PhosphorIcons.map_pin)),
                          ),
                          GestureDetector(
                            child: TextFieldBlocBuilder(
                              textFieldBloc: loginFormBloc.destination,
                              readOnly: true,
                              decoration: inputDecoration(
                                  labelText: 'Destination',
                                  prefixIcon:
                                      const Icon(PhosphorIcons.map_pin)),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() async {}),
                            child: TextFieldBlocBuilder(
                              textFieldBloc: loginFormBloc.departureDate,
                              readOnly: true,
                              decoration: inputDecoration(
                                  labelText: 'Departure Date',
                                  prefixIcon:
                                      const Icon(PhosphorIcons.calendar)),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() async {}),
                            child: TextFieldBlocBuilder(
                              textFieldBloc: loginFormBloc.departureTime,
                              readOnly: true,
                              decoration: inputDecoration(
                                  labelText: 'Departure Time',
                                  prefixIcon: const Icon(PhosphorIcons.clock)),
                            ),
                          ),
                          TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.noPassengers,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: inputDecoration(
                              labelText: 'No. Passengers',
                              prefixIcon: const Icon(PhosphorIcons.users_three),
                              //     suffixIcon: Icon(PhosphorIcons.eyeSlash),
                            ),
                          ),
                          TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.selectedOperator,
                            readOnly: true,
                            keyboardType: TextInputType.streetAddress,
                            decoration: inputDecoration(
                              labelText: 'Selected Operator',
                              prefixIcon: const Icon(PhosphorIcons.users_three),
                              //     suffixIcon: Icon(PhosphorIcons.eyeSlash),
                            ),
                          ),
                          TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.bookingBy,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: inputDecoration(
                              labelText: 'Booking Made by',
                              prefixIcon: const Icon(PhosphorIcons.user),
                              //     suffixIcon: Icon(PhosphorIcons.eyeSlash),
                            ),
                          ),
                          5.height,
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

                          BlocBuilder<BookingDetailsFormBloc, FormBlocState>(
                            bloc: loginFormBloc,
                            builder: (context, FormBlocState state) {
                              return Column(
                                children: [
                                  AppButton(
                                    title: 'Share Reciept',
                                    onPressed: () async {
                                      await getPdf(context, model, false);
                                    },
                                    isDisabled: state.isValid(0) ? false : true,
                                  ),
                                  10.height,
                                  AppButton(
                                    title: 'Save Reciept',
                                    onPressed: () async {
                                      await getPdf(context, model, true);
                                    },
                                    isDisabled: state.isValid(0) ? false : true,
                                  ),
                                ],
                              );
                            },
                          ),
                          /*  Row(
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
      ),
    );
  }
}
