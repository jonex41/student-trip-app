import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton, log;
import 'package:student_project/auth/helpers.dart';
import 'package:student_project/booking/provider/booking_form_bloc.dart';
import 'package:student_project/booking/provider/booking_provider.dart';
import 'package:student_project/data/models/booking_model.dart';
import 'package:student_project/utils/app_button.dart';
import 'package:student_project/utils/constants.dart';

import '../../home/provider/home_page_provider.dart';
import '../../home/view/home_screen.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loader.dart';

import 'booking_operator_list.dart';

class BookingScreen extends HookConsumerWidget {
  BookingScreen({super.key});
  LatLng destinationPosition = const LatLng(0, 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = useState('none');

    // final initialPosition = useState<LatLng>(const LatLng(7.142133, 6.301505));
    //final destinationPosition = useState<LatLng>(const LatLng(7.142133, 6.301505));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Book Trip",
            style: GoogleFonts.poppins(
                color: black,
                textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: BlocProvider(
          create: (context) => BookingFormBloc(),
          child: Builder(builder: (context) {
            final loginFormBloc = context.read<BookingFormBloc>();
            final destinationAddress = ref.watch(addressProvider2);
            // if (!destinationAddress.isEmptyOrNull) {
            loginFormBloc.destination
                .updateInitialValue(destinationAddress.first);
            selectedValue.value = destinationAddress[0];
            destinationPosition = LatLng(destinationAddress[1].toDouble(),
                destinationAddress[2].toDouble());
            //}
            LatLng initialPosition = const LatLng(0, 0);
            log("here kkkkkkkkkkkk");
            Geolocator.getCurrentPosition().then((value) {
              log("here oooooooooo");
              log("here ${value.latitude} ${value.longitude}");
              initialPosition = LatLng(value.latitude, value.longitude);

              placemarkFromCoordinates(value.latitude, value.longitude)
                  .then((placeMarker) {
                loginFormBloc.from.updateInitialValue(
                    ' ${placeMarker.first.subAdministrativeArea} ${placeMarker.first.locality!},  ${placeMarker.first.administrativeArea!} ');

                //log(placeMarker.);
              });
            });
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  body: SafeArea(
                child: FormBlocListener<BookingFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    showLoader(context);
                  },
                  onSuccess: (context, state) {
                    hideLoader();
                    ref.read(bookingDetailsProvider.notifier).state =
                        BookingModel(
                      source: loginFormBloc.from.value,
                      destination: loginFormBloc.destination.value,
                      departureDate: loginFormBloc.departureDate.value,
                      departureTime: loginFormBloc.departureTime.value,
                      bookinRef: '',
                      latS: initialPosition.latitude,
                      longS: initialPosition.longitude,
                      latD: destinationPosition.latitude,
                      longD: destinationPosition.longitude,
                      progress: kWaiting,
                      date: DateTime.now().toString(),
                      time: TimeOfDay.now().toString(),
                      noPassenger: loginFormBloc.noPassengers.value.toInt(),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PickOperatorPage()),
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
                          textFieldBloc: loginFormBloc.from,
                          decoration: inputDecoration(
                              labelText: 'From',
                              prefixIcon: const Icon(PhosphorIcons.map_pin)),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }),
                          child: TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.destination,
                            isEnabled: false,
                            decoration: inputDecoration(
                                labelText: 'Destination',
                                prefixIcon: const Icon(PhosphorIcons.map_pin)),
                          ),
                        ),
                        /*   Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFD1D2D8))),
                          child: SearchChoices.single(
                            onClear: () {
                              loginFormBloc.destination.updateValue('');
                              selectedValue.value = 'none';
                              showSnackBar('here');
                            },
                            items: const [
                              DropdownMenuItem(
                                /* Latitude: N 7°8'9.01284"
Longitude: E 6°18'28.12572"
 */
                                value: 'Admin building =7.1358369,6.3078127',
                                child: Text('Admin building'),
                              ),
                              DropdownMenuItem(
                                /* Latitude: N 7°8'20.71644"
Longitude: E 6°18'13.36896"
 */
                                value: 'Female hostel1 =7.1390879,6.3037136',
                                child: Text('Female hostel1'),
                              ),
                              DropdownMenuItem(
                                /* Latitude: N 7°8'13.41132"
Longitude: E 6°18'18.1152"
 */
                                value: 'EDSU health center =7.1370587,6.305032',
                                child: Text('EDSU health center '),
                              ),
                              DropdownMenuItem(
                                /* Latitude: N 7°8'0.97584"
Longitude: E 6°17'49.30332"
 */
                                value: 'Male hostel 1 =7.1336044,6.2970287',
                                child: Text('Male hostel 1'),
                              ),
                              DropdownMenuItem(
                                /* Latitude: N 7°8'41.82324"
Longitude: E 6°17'40.7076"
 */
                                value: 'EDSU male hostel 3 =7.1449509,6.294641',
                                child: Text('EDSU male hostel 3 '),
                              ),
                              DropdownMenuItem(
                                /* Latitude: N 7°8'40.05744"
Longitude: E 6°17'39.53868"
 */
                                value: 'Female hostel4 =7.1444604,6.2943163',
                                child: Text('Female hostel4'),
                              ),
                              DropdownMenuItem(
                                value:
                                    'Faculty building area =7.1519135,6.3016819',
                                child: Text('Faculty building area'),
                              ),
                              DropdownMenuItem(
                                value: 'Faculty of BCS =7.1459536,6.2966428',
                                child: Text('Faculty of BCS'),
                              ),
                              /* DropdownMenuItem(
                                
                                value: '',
                                child: Text(''),
                              ), */
                            ],
                            value: selectedValue.value,
                            hint: "Pick Destination",
                            searchHint: "Select one",
                            onChanged: (value) {
                              List<String> list = value.split('=');
                              loginFormBloc.destination
                                  .updateValue(list.first.trim());
                              selectedValue.value = list.first.trim();
                              destinationPosition = LatLng(
                                  list.last.split(',').first.toDouble(),
                                  list.last.split(',').last.toDouble());
                              /*  setState(() {
                                    selectedValueSingleDialog = value;
                                  });
                         */
                            },
                            isExpanded: true,
                          ),
                        ),
                         */
                        GestureDetector(
                          onTap: (() async {
                            final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2070, 8));
                            if (dateTime != null) {
                              loginFormBloc.departureDate.updateInitialValue(
                                  DateFormat('dd MMM, yyyy').format(dateTime));
                            }
                          }),
                          child: TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.departureDate,
                            isEnabled: false,
                            decoration: inputDecoration(
                                labelText: 'Departure Date',
                                prefixIcon: const Icon(PhosphorIcons.calendar)),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() async {
                            TimeOfDay selectedTime = TimeOfDay.now();
                            final TimeOfDay? timePicker = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (timePicker != null) {
                              final localizations =
                                  MaterialLocalizations.of(context);
                              final formattedTimeOfDay =
                                  localizations.formatTimeOfDay(timePicker);
                              loginFormBloc.departureTime
                                  .updateInitialValue(formattedTimeOfDay);
                            }
                          }),
                          child: TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.departureTime,
                            isEnabled: false,
                            decoration: inputDecoration(
                                labelText: 'Departure Time',
                                prefixIcon: const Icon(PhosphorIcons.clock)),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.noPassengers,
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration(
                            labelText: 'No. Passengers',
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

                        BlocBuilder<BookingFormBloc, FormBlocState>(
                          bloc: loginFormBloc,
                          builder: (context, FormBlocState state) {
                            return AppButton(
                              title: 'Make Reservation',
                              onPressed: loginFormBloc.submit,
                              isDisabled: state.isValid(0) ? false : true,
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
