import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:student_project/utils/app_button.dart';

import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';
import '../user_location/providers/vehicle_operation_form.dart';

class VehiclesOperation extends HookConsumerWidget {
  const VehiclesOperation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final model = ref.read(bookingDetailsProvider.notifier).state;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Vehicles Operation",
            style: GoogleFonts.poppins(
                color: white,
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: BlocProvider(
          create: (context) => VeicleOperationFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<VeicleOperationFormBloc>();
            /*     loginFormBloc.from.updateInitialValue(model.source!);
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
 */
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  body: SafeArea(
                child:
                    FormBlocListener<VeicleOperationFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    showLoader(context);
                  },
                  onSuccess: (context, state) {
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
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.trip_in_progress,
                          decoration: inputDecoration(
                              labelText: 'Trip in Progress',
                              prefixIcon:
                                  const Icon(PhosphorIcons.chalkboard_teacher)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.vehicle_in_que,
                          decoration: inputDecoration(
                              labelText: 'Vehicle in queue',
                              prefixIcon: const Icon(PhosphorIcons.car_simple)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.completed_trips,
                          decoration: inputDecoration(
                              labelText: 'Completed Trip',
                              prefixIcon: const Icon(PhosphorIcons.car_simple)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.cummuter_statistics,
                          decoration: inputDecoration(
                              labelText: 'Commuter Statistics',
                              prefixIcon: const Icon(PhosphorIcons.calendar)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.destination,
                          decoration: inputDecoration(
                              labelText: 'Destination',
                              prefixIcon: const Icon(PhosphorIcons.house_line)),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.dailly_no_of_trip,
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration(
                            labelText: 'Daily no. of Trips',
                            prefixIcon: const Icon(PhosphorIcons.users_three),
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

                        BlocBuilder<VeicleOperationFormBloc, FormBlocState>(
                          bloc: loginFormBloc,
                          builder: (context, FormBlocState state) {
                            return Column(
                              children: [
                                AppButton(
                                  title: 'Save',
                                  onPressed: loginFormBloc.submit,
                                  isDisabled: state.isValid(0) ? false : true,
                                ),
                                /*  10.height,
                                AppButton(
                                  title: 'Save Reciept',
                                  onPressed: () async {
                                    await getPdf(context, model, true);
                                  },
                                  isDisabled: state.isValid(0) ? false : true,
                                ), */
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
    );
  }
}
