import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/utils/colors.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({super.key});

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
            child: Icon(
              PhosphorIcons.x,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Your route',
            style: GoogleFonts.poppins(
                color: Colors.black,
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Container(
                color: black4,
                child: TextField(
                    onTap: (() {}),
                    enabled: false,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Current position",
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: black4, width: 32.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(25.0)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
