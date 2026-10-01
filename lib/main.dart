// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';
// import 'screens/home_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const TambolaApp());
// }

// class TambolaApp extends StatelessWidget {
//   const TambolaApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeAnimationDuration: Duration.zero,
//       title: 'Tambola Multiplayer',
//       theme: ThemeData(
//         colorSchemeSeed: Colors.deepPurple,
//         useMaterial3: true,
//         fontFamily: 'Roboto',
//       ),

//       // FIXED HERE
//       home: HomeScreen(),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  // =========================
  // FLUTTER INIT
  // =========================

  WidgetsFlutterBinding.ensureInitialized();

  // =========================
  // FIREBASE INIT
  // =========================

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // =========================
  // RUN APP
  // =========================

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Influencer Tambola',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}
