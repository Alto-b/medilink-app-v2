import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/appointment_model.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/model/feedback_model.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/admin/model/telemedicine_model.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/splash.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME ="UserLoggedIn";
Future<void> main() async {

   WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

   Hive.openBox<DepartmentModel>('dept_db');
   Hive.openBox<HospModel>('hosp_db');
   Hive.openBox<UserModel>('user_db');
   Hive.openBox<FeedBackModel>('feedback_db');
   Hive.openBox<TelemedicineModel>('telemedicine_db');
   Hive.openBox<AppointmentModel>('appointment_db');
   Hive.openBox<DoctorModel>('doctor_db');
  
  if(!Hive.isAdapterRegistered(DepartmentModelAdapter().typeId)){
      Hive.registerAdapter(DepartmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(HospModelAdapter().typeId)){
      Hive.registerAdapter(HospModelAdapter());
  }
  if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
    Hive.registerAdapter(UserModelAdapter());
  }
  if(!Hive.isAdapterRegistered(FeedBackModelAdapter().typeId)){
    Hive.registerAdapter(FeedBackModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TelemedicineModelAdapter().typeId)){
    Hive.registerAdapter(TelemedicineModelAdapter());
  }
  if(!Hive.isAdapterRegistered(AppointmentModelAdapter().typeId)){
    Hive.registerAdapter(AppointmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(DoctorModelAdapter().typeId)){
    Hive.registerAdapter(DoctorModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medilink',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      
      home: const Splash()
    );
  }
}
