import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Whatsapp extends StatefulWidget {
  Whatsapp({Key key}) : super(key: key);

  @override
  _WhatsappState createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  Text _title(int count) {
    return Text("$count");
  }

  @override
  Widget build(BuildContext context) {
    return ContextualActionScaffold<User>(
      appBar: AppBar(
        title: Text("WhatsApp"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Long press on any of the items")));
              }),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("Refresh"),
                value: "refresh",
              ),
            ],
            onSelected: (String val) {
              if (val == "refresh") {
                users = _users();
                setState(() {});
              }
            },
          )
        ],
      ),
      contextualAppBar: ContextualAppBar(
        counterBuilder: _title,
        closeIcon: Icons.arrow_back,
        contextualActions: [
          ContextualAction(
            itemsHandler: (List<User> items) async {
              await Future.delayed(const Duration(milliseconds: 200), () {
                users.removeWhere((user) => items.contains(user));
                users = users;
                setState(() {});
              });
            },
            child: Icon(Icons.delete),
          ),
          ContextualAction(
            itemsHandler: (List<User> items) {
              items.forEach((user) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$user saved"),
                ));
              });
            },
            child: Icon(Icons.save),
          ),
          ContextualAction(
            itemsHandler: (List<User> _) async {},
            child: Builder(builder: (context) {
              return PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Select all"),
                      value: "all",
                    ),
                  ];
                },
                onSelected: (String value) {
                  if (value == "all") {
                    ActionMode.addItems(context, users);
                  }
                },
              );
            }),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return Center(
          child: ListView(
            children: <Widget>[
              ...users.map((user) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ContextualActionWidget(
                        data: user,
                        child: ListTile(
                          onTap: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("$user"),
                            ));
                          },
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                            radius: 25,
                          ),
                          title: Text("${user.name}"),
                          subtitle: Text("${user.lastMessageSent}"),
                        ),
                        selectedWidget: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 50, top: 20),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ))
            ],
          ),
        );
      }),
    );
  }
}

List<User> users = _users();
List<User> _users() => [
      User(name: "Morgan"),
      User(name: "John"),
      User(name: "Mary"),
      User(name: "Johnson"),
      User(name: "Smith"),
      User(name: "Grace"),
      User(name: "Jesse"),
      User(name: "Williams"),
      User(name: "Joseph"),
      User(name: "Michael"),
    ];

// User must have value equality
class User extends Equatable {
  final String name;
  final String lastMessageSent;
  User({this.name = "Morgan", this.lastMessageSent = "How are you?"});
  @override
  List<Object> get props => [name];

  @override
  String toString() => name;
}
