import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WhatsApp extends StatefulWidget {
  @override
  _WhatsAppState createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> with ContextualMixin {
  @override
  Widget build(BuildContext context) {
    // You can next as many ContextualScaffold as you have
    return ContextualScaffold<User>(
      contextualAppBar: userContextualAppBar,
      body: ContextualScaffold<Call>(
        contextualAppBar: callsContextualAppBar,
        body: WhatsAppBody(),
      ),
    );
  }
}

class WhatsAppBody extends StatefulWidget {
  @override
  _WhatsAppBodyState createState() => _WhatsAppBodyState();
}

class _WhatsAppBodyState extends State<WhatsAppBody>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isUserActionModeEnabled = false;
  bool _isCallActionModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (_tabController!.indexIsChanging && _isUserActionModeEnabled) {
          ActionMode.disable<User>(context);
        }
        if (_tabController!.indexIsChanging && _isCallActionModeEnabled) {
          ActionMode.disable<Call>(context);
        }
      });
    ActionMode.enabledStream<User>(context).listen((event) {
      _isUserActionModeEnabled = event;
    });
    ActionMode.enabledStream<Call>(context).listen((event) {
      _isCallActionModeEnabled = event;
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverAppBar(
          title: Text("WhatsApp"),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate:
                _SliverAppBarDelegate(TabBar(controller: _tabController, tabs: [
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "Status".toUpperCase(),
              ),
              Tab(
                text: "Calls".toUpperCase(),
              ),
            ])))
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          Chats(),
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
    ActionMode.enabledStream<Call>(context).listen((event) {
      print("Call Action mode is enabled $event");
    });
    return Center(
      child: ListView(
        children: <Widget>[
          ...calls.map((call) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ContextualActionWidget(
                    data: call,
                    child: ListTile(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$call"),
                        ));
                      },
                      leading: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () {},
                        ),
                        radius: 25,
                      ),
                      title: Text("${call.friend.name}"),
                      subtitle: Text("${call._callTime}"),
                      trailing: Icon(
                        Icons.call,
                        color: Colors.teal,
                      ),
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

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActionMode.enabledStream<User>(context).listen((event) {
      print("User Action mode is enabled $event");
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
      User(name: "Henry"),
      User(name: "Jordan"),
      User(name: "Michelle"),
    ];

// Call must be unique

class Call extends Equatable {
  final User friend;
  final String _callTime;

  Call(this.friend, [String? callTime])
      : _callTime = callTime ?? "August 20, 11:30AM";

  @override
  List<Object> get props => [friend];
}

List<Call> calls = _calls();

List<Call> _calls() => _users().map((e) => Call(e)).toList();

extension ContextExtenstion on BuildContext {
  void showSnackBar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(message),
      ));
}

mixin ContextualMixin<Page extends StatefulWidget> on State<Page> {
  ContextualAppBar<User> get userContextualAppBar => ContextualAppBar(
        elevation: 0.0,
        counterBuilder: (int itemsCount) => Text("$itemsCount"),
        closeIcon: Icons.arrow_back,
        contextualActions: [
          ContextualAction(
            itemsHandler: (List<User> items) =>
                items.forEach((user) => context.showSnackBar(user.name)),
            child: Icon(Icons.save),
          ),
          ContextualAction(
            itemsHandler: (List<User> items) => items.forEach((user) {
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

  ContextualAppBar<Call> get callsContextualAppBar => ContextualAppBar(
        elevation: 0.0,
        closeIcon: Icons.arrow_back,
        counterBuilder: (int itemsCount) => Text("$itemsCount"),
        contextualActions: [
          ContextualAction(
            itemsHandler: (List<Call> items) =>
                items.forEach((call) => context.showSnackBar(call.friend.name)),
            child: Icon(Icons.save),
          ),
          ContextualAction(
            itemsHandler: (List<Call> items) => items.forEach((call) {
              calls.remove(call);
              setState(() {});
            }),
            child: Icon(Icons.delete),
          ),
          ContextualAction(
            itemsHandler: (List<Call> _) {},
            child: Builder(builder: (context) {
              return PopupMenuButton<String>(
                onSelected: (val) {
                  switch (val) {
                    case "select":
                      ActionMode.addItems(context, calls);
                      setState(() {});
                      break;
                    case "disable":
                      ActionMode.disable<Call>(context);
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
