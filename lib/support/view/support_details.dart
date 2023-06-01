import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class SupportDetailsScreen extends ConsumerWidget {
  final firstText;
  final secondText;
  const SupportDetailsScreen({super.key, this.firstText, this.secondText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: (() {
              context.pop();
            }),
            child: const Icon(
              PhosphorIcons.x,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Get help',
            style: GoogleFonts.poppins(
                color: Colors.black,
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Text(
                firstText,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              Text(
                secondText,
                style: GoogleFonts.poppins(
                    color: Colors.black54,
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ),
              50.height,
              Text(
                'You can Contact 08051902743 for help and complain',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
