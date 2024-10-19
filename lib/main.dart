import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:record/record.dart';
import 'package:voice_control_race_game/my_home_page.dart';
import 'package:voice_control_race_game/pitch_detecter.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: MyHomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AudioRecorder>(
          create: (context) => AudioRecorder(),
        ),
        RepositoryProvider<PitchDetector>(
          create: (context) => PitchDetector(),
        ),
        RepositoryProvider<PitchHandler>(
          create: (context) => PitchHandler(InstrumentType.guitar),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<PitchCubit>(
              create: (context) => PitchCubit(
                context.read<AudioRecorder>(),
                context.read<PitchDetector>(),
              ),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(),
          )),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final pitchCubitState = context.watch<PitchCubit>().state;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Pitchup sample- Guitar tuner"),
//       ),
//       body: Center(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Text(
//                 pitchCubitState.note,
//                 style: const TextStyle(
//                     color: Colors.black87,
//                     fontSize: 65.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 pitchCubitState.status,
//                 style: const TextStyle(
//                   color: Colors.black87,
//                   fontSize: 18.0,
//                 ),
//               ),
//             ]),
//       ),
//     );
//   }
// }
