# Flutter contextual action bar(CAB)

A reliable contextual action bar workaround for flutter.
![](https://raw.githubusercontent.com/De-Morgan/flutter-contextual-action-bar/master/screenshots/snapshot.png)


# CAB & Flutter
CAB is a top app bar that replace the app app bar to provide contextual actions to selected items. Check the material implementation and requirement [here](https://material.io/components/app-bars-top#contextual-action-bar)

Flutter does not natively support CAB yet. see [issue](https://github.com/flutter/flutter/issues/44464)
Until CAB is natively supported, this package should provide you with an elegant way to implement the contextual action bar in flutter.


## How it works

- `ContextualActionScaffold`
- `ContextualAppBar`
- `ContextualAction`
- `ContextualActionWidget`

## `ContextualActionScaffold<?>`

The `ContextualActionScaffold<?>` is similar to the normal material `Scaffold` except that it also takes
a required `contextualAppBar`.

```
ContextualActionScaffold<?>(
      appBar: AppBar(),
      contextualAppBar: ContextualAppBar(),
      body: Body(),
    )
 ```

## `ContextualAppBar<?>`
The `ContextualAppBar<?>` is similar to the normal material `Appbar` but takes a `counterBuilder` instead of `title` and also a `contextualActions` instead of `actions.

```
 ContextualAppBar(
      counterBuilder: (int itemsCount){
        return Text("$itemsCount Selected");
      },
      contextualActions: <ContextualAction>[],
    )
   ```

## `ContextualAction<?>`

The `ContextualAction<?>` allows you to take actions on the selected items, with the help of `itemsHandler` callback.

```
ContextualAction(
            itemsHandler: (List<?> items) {
              items.forEach((item) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$item saved"),
                ));
              });
            },
            child: Icon(Icons.save),
          ),
 ```


## `ContextualActionWidget<?>`

You can use the `ContextualActionWidget` anywhere in the `ContextualActionScaffold` `body` to notify  `ContextualActionScaffold` that an item have been selected in order to show the `ContextualAppBar`. 

```
   ContextualActionWidget(
          data: ?,
          child: ChildWidget(),
        )
 ```
 
 *Note: It is important that the child widget does not handle onLongPress.*
 
 ***Study complete examples at [example page](https://github.com/De-Morgan/flutter-contextual-action-bar/blob/master/example/lib/main.dart)***
 
 ### Other Packages authored by me
 
 - [loadinglistview](https://pub.dev/packages/loadinglistview#-readme-tab-)

## License
This package is licensed under the MIT license. See [LICENSE](https://github.com/De-Morgan/flutter-contextual-action-bar/blob/master/LICENSE) for details.


 
