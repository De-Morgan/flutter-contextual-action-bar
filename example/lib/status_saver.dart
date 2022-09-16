import 'dart:io';

import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';

final Directory _photoDir =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
final imageList = _photoDir
    .listSync()
    .map((item) => item.path)
    .where((item) => item.endsWith(".jpg"))
    .toList(growable: false);

class StatusSaver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContextualScaffold<String>(
      appBar: AppBar(
        title: const Text("status saver"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                showSnackbar(context, 'Long press on any image');
              })
        ],
      ),
      contextualAppBar: ContextualAppBar(
        counterBuilder: (int count) {
          return Text("$count");
        },
        contextualActions: [
          ContextualAction(
            itemsHandler: (List<String> items) {
              showSnackbar(context, "${items.length} images saved");
            },
            child: Icon(Icons.save),
          ),
          ContextualAction(
            itemsHandler: (List<String> items) {
              showSnackbar(context, "${items.length} images shared");
            },
            child: Icon(Icons.share),
          ),
          ContextualAction(
            itemsHandler: (List<String> items) {
              showSnackbar(context, "${items.length} images deleted");
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: _ImageScreen(),
    );
  }
}

class _ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => new _ImageScreenState();
}

class _ImageScreenState extends State<_ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Center(
        child: Text(
          "Install WhatsApp\nYour Friend's Status Will Be Available Here",
          style: TextStyle(fontSize: 18.0),
        ),
      );
    } else {
      if (imageList.length > 0) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: imageList.length,
            itemBuilder: (BuildContext context, int index) {
              final imgPath = imageList[index];
              return ContextualActionWidget(
                selectedWidget: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.teal,
                  ),
                ),
                unselectedWidget: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white60,
                  ),
                ),
                data: imgPath,
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {},
                    child: Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'Sorry, No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}

void showSnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
