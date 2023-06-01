import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class ConfirmScreen extends ConsumerWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          8.height,
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
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Icon(PhosphorIcons.question),
            ],
          ),
          75.height,
          Container(
            height: 140.0,
            width: 140.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: SvgPicture.asset(
              "assets/images/gray_square.svg",
            ),
          ),
          44.height,
          Align(
            alignment: Alignment.center,
            child: Text(
              'Check your mail',
              style: GoogleFonts.poppins(
                  color: black,
                  textStyle:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
            ),
          ),
          1.height,
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'We have sent a password recover instructions\n to your email',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: gray,
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Open email app',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: black,
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Skip, i’ll confirm later',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: gray,
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Do not receive the email? Check spam filter',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: black,
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
