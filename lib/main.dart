import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:controlpul/views/InicialView.dart';
import 'constantes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // TODO: Replace credentials with your own
    url: 'https://jqqakpagetmrkylccnrk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxcWFrcGFnZXRtcmt5bGNjbnJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE5MzMxOTYsImV4cCI6MTk5NzUwOTE5Nn0.jTbIv9FVfpyVgWM2khTNAPEonMMto6cu2zcuIUU8jXE',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ControlPool',
      theme: appTheme,
      home: InicialView(),
    );
  }
}