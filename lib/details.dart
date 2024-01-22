import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/drawer.dart';
import 'package:loginapp/ui/gridDashboard.dart';


class DataScreen extends StatefulWidget {
  final String email;

  const DataScreen({super.key, required this.email});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xee0d0f10),
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: Column(

      ),
    );
  }
}
