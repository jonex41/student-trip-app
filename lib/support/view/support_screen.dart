import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/support/view/support_details.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

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
                'Journey issues',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              Text(
                'Browse common trip related issues  and get in touch with our support team below',
                style: GoogleFonts.poppins(
                    color: Colors.black54,
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ),
              10.height,
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'i was charged twice for same trip',
                        secondText: 'i was charged twice for same trip',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'i was charged twice for same trip',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Issue with a cancellation fee',
                        secondText: 'Issue with a cancellation fee',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Issue with a cancellation fee',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'My driver was rude',
                        secondText: 'My driver was rude',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'My driver was rude',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'My driver was rude',
                        secondText: 'My driver was rude',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'My driver was rude',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              Text(
                'Things you should know when booking a ride with us',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Prepare for your trip',
                        secondText: 'Prepare for your trip',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Prepare for your trip',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Confirm your vehicle',
                        secondText: 'Confirm your vehicle',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Confirm your vehicle',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Recognize your driver',
                        secondText: 'Recognize your driver',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Recognize your driver',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Seat in the backseat',
                        secondText: 'Seat in the backseat',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Seat in the backseat',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Use your seatbelts',
                        secondText: 'Use your seatbelts',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Use your seatbelts',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Be amiable and respectful',
                        secondText: 'Be amiable and respectful',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Be amiable and respectful',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
            ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Don’t reveal too many personal details',
                        secondText: 'Don’t reveal too many personal details',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Don’t reveal too many personal details',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
            ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Rate your driver',
                        secondText: 'Rate your driver',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Rate your driver',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
           ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'Listen to intuition',
                        secondText: 'Listen to intuition',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'Listen to intuition',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
           ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'You can cancel your trip',
                        secondText: 'You can cancel your trip',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'You can cancel your trip',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
            ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportDetailsScreen(
                        firstText: 'How to cancel your trip',
                        secondText: 'Go to Booking history and cancel',
                      ),
                    ),
                  );
                }),
                title: Text(
                  'How to cancel your trip',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54)),
                ),
                trailing: const Icon(PhosphorIcons.caret_right),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
