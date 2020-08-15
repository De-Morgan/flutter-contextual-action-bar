import 'package:flutter/material.dart';

import 'whatsapp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contextual Action Bar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      // for Scaffold.of(context)
      //home: Scaffold(body: Whatsapp()),
      home: Scaffold(
        body: SliverWhatsappExample(),
      ),
//        home: Scaffold(
//          body: StreamBuilder<PermissionStatus>(
//              stream: (StoragePermissionService()..requestPermission())
//                  .storagePermission,
//              builder: (context, snapshot) {
//                if (snapshot.hasData && snapshot.data.isGranted) {
//                  return StatusSaver();
//                }
//                return Container(
//                  alignment: FractionalOffset.center,
//                  child: const CircularProgressIndicator(),
//                );
//              }),
//        )
    );
  }
}
