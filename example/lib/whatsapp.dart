import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Whatsapp extends StatefulWidget {
  @override
  _WhatsappState createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> with ContextualMixin {
  @override
  Widget build(BuildContext context) {
    return ContextualActionScaffold<User>(
      contextualAppBar: contexualActionBar,
      appBar: AppBar(
        title: Text("Whatsapp"),
      ),
      body: WhatsappBody(),
    );
  }
}

class SliverWhatsappExample extends StatefulWidget {
  @override
  _SliverWhatsappExampleState createState() => _SliverWhatsappExampleState();
}

class _SliverWhatsappExampleState extends State<SliverWhatsappExample>
    with ContextualMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ContextualScrollView<User>(
      contextualAppBar: contexualActionBar,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverAppBar(
          title: Text("Whatsapp"),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate:
                _SliverAppBarDelegate(TabBar(controller: _tabController, tabs: [
              Tab(
                text: "Chat",
              ),
              Tab(
                text: "Status",
              ),
              Tab(
                text: "Calls",
              ),
            ])))
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          WhatsappBody(),
          Status(),
          Calls(),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Status"),
    );
  }
}

class Calls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Calls"),
    );
  }
}

class WhatsappBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActionMode.enabledStream<User>(context).listen((event) {
      print("Action mode is enabled $event");
    });

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
                        child: IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () {},
                        ),
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
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
      color: Colors.teal,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// User must be unique
class User extends Equatable {
  final String name;
  final String lastMessageSent;

  User({this.name = "Morgan", this.lastMessageSent = "How are you?"});

  @override
  List<Object> get props => [name];

  @override
  String toString() => name;
}

List<User> users = _users();

List<User> _users() =>
    [
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
      User(name: "Henry"),
      User(name: "Jordan"),
      User(name: "Michelle"),
    ];

extension ContextExtenstion on BuildContext {
  void showSnackBar(String message) =>
      Scaffold.of(this).showSnackBar(SnackBar(
        content: Text(message),
      ));
}

mixin ContextualMixin<Page extends StatefulWidget> on State<Page> {
  ContextualAppBar<User> get contexualActionBar =>
      ContextualAppBar(
        elevation: 0.0,
        counterBuilder: (int itemsCount) => Text("$itemsCount"),
        contextualActions: [
          ContextualAction(
            itemsHandler: (List<User> items) =>
                items.forEach((user) => context.showSnackBar(user.name)),
            child: Icon(Icons.save),
          ),
          ContextualAction(
            itemsHandler: (List<User> items) =>
                items.forEach((user) {
                  users.remove(user);
                  setState(() {});
                }),
            child: Icon(Icons.delete),
          ),
          ContextualAction(
            itemsHandler: (List<User> _) {},
            child: Builder(builder: (context) {
              return PopupMenuButton<String>(
                onSelected: (val) {
                  switch (val) {
                    case "select":
                      ActionMode.addItems(context, users);
                      setState(() {});
                      break;
                    case "disable":
                      ActionMode.disable<User>(context);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Select all"),
                      value: "select",
                    ),
                    PopupMenuItem(
                      child: Text("Deselect all"),
                      value: "disable",
                    ),
                  ];
                },
              );
            }),
          )
        ],
      );
}
