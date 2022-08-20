import 'package:flutter/material.dart';
import 'package:ticketparser/config/image_picker.dart';
import 'package:ticketparser/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImagePickerConfiguration.configImagePicker();
    return MaterialApp(
      title: 'Ticket Parser Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }  
}
