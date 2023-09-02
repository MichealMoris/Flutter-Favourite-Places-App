import 'package:favourite_places_app/screens/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 56, 49, 66),
);

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: colorScheme.background,
        colorScheme: colorScheme,
        textTheme:
            GoogleFonts.ubuntuCondensedTextTheme(Theme.of(context).textTheme)
                .copyWith(
          titleSmall: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const PlacesScreen(),
    );
  }
}
