import 'package:firebase_core/firebase_core.dart';
import 'package:wiser_clone_app/services/ai_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:wiser_clone_app/main_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AiService.initialize();
  runApp(const MainWidget());
}
