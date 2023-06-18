part of widgets;

class ContextualAppBar<T> extends StatelessWidget {
  /// The primary widget displayed in the app bar.
  ///  The itemsCount property gives you the count of the selected items.
  /// Typically a [Text] widget containing a description of the current contents
  /// of the app.
  final CounterBuilder counterBuilder;

  /// Widgets to display after the [counterBuilder] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  final List<ContextualAction<T>> contextualActions;

  /// {@template flutter.material.appbar.automaticallyImplyLeading}
  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  /// {@endtemplate}
  final bool automaticallyImplyLeading;

  /// Icon to use to close Action mode
  final IconData? closeIcon;

  /// {@template flutter.material.appbar.flexibleSpace}
  /// This widget is stacked behind the toolbar and the tab bar. Its height will
  /// be the same as the app bar's overall height.
  ///
  /// A flexible space isn't actually flexible unless the [AppBar]'s container
  /// changes the [AppBar]'s size. A [SliverAppBar] in a [CustomScrollView]
  /// changes the [AppBar]'s height when scrolled.
  ///
  /// Typically a [FlexibleSpaceBar]. See [FlexibleSpaceBar] for details.
  /// {@endtemplate}
  final Widget? flexibleSpace;

  /// {@template flutter.material.appbar.bottom}
  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget] can
  /// be used at the bottom of an app bar.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [PreferredSize], which can be used to give an arbitrary widget a preferred size.
  final PreferredSizeWidget? bottom;

  /// {@template flutter.material.appbar.elevation}
  /// The z-coordinate at which to place this app bar relative to its parent.
  ///
  /// This property controls the size of the shadow below the app bar if
  /// [shadowColor] is not null.
  ///
  /// If [surfaceTintColor] is not null then it will apply a surface tint overlay
  /// to the background color (see [Material.surfaceTintColor] for more
  /// detail).
  ///
  /// The value must be non-negative.
  ///
  /// If this property is null, then [AppBarTheme.elevation] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the
  /// default value is 4.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [scrolledUnderElevation], which will be used when the app bar has
  ///    something scrolled underneath it.
  ///  * [shadowColor], which is the color of the shadow below the app bar.
  ///  * [surfaceTintColor], which determines the elevation overlay that will
  ///    be applied to the background of the app bar.
  ///  * [shape], which defines the shape of the app bar's [Material] and its
  ///    shadow.
  final double? elevation;

  /// {@template flutter.material.appbar.scrolledUnderElevation}
  /// The elevation that will be used if this app bar has something
  /// scrolled underneath it.
  ///
  /// If non-null then it [AppBarTheme.scrolledUnderElevation] of
  /// [ThemeData.appBarTheme] will be used. If that is also null then [elevation]
  /// will be used.
  ///
  /// The value must be non-negative.
  ///
  /// {@endtemplate}
  ///
  /// See also:
  ///  * [elevation], which will be used if there is no content scrolled under
  ///    the app bar.
  ///  * [shadowColor], which is the color of the shadow below the app bar.
  ///  * [surfaceTintColor], which determines the elevation overlay that will
  ///    be applied to the background of the app bar.
  ///  * [shape], which defines the shape of the app bar's [Material] and its
  ///    shadow.
  final double? scrolledUnderElevation;

  /// A check that specifies which child's [ScrollNotification]s should be
  /// listened to.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// {@template flutter.material.appbar.shadowColor}
  /// The color of the shadow below the app bar.
  ///
  /// If this property is null, then [AppBarTheme.shadowColor] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the default value
  /// is fully opaque black.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [elevation], which defines the size of the shadow below the app bar.
  ///  * [shape], which defines the shape of the app bar and its shadow.
  final Color? shadowColor;

  /// {@template flutter.material.appbar.surfaceTintColor}
  /// The color of the surface tint overlay applied to the app bar's
  /// background color to indicate elevation.
  ///
  /// If null no overlay will be applied.
  /// {@endtemplate}
  ///
  /// See also:
  ///   * [Material.surfaceTintColor], which described this feature in more detail.
  final Color? surfaceTintColor;

  /// {@template flutter.material.appbar.shape}
  /// The shape of the app bar's [Material] as well as its shadow.
  ///
  /// If this property is null, then [AppBarTheme.shape] of
  /// [ThemeData.appBarTheme] is used. Both properties default to null.
  /// If both properties are null then the shape of the app bar's [Material]
  /// is just a simple rectangle.
  ///
  /// A shadow is only displayed if the [elevation] is greater than
  /// zero.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [elevation], which defines the size of the shadow below the app bar.
  ///  * [shadowColor], which is the color of the shadow below the app bar.
  final ShapeBorder? shape;

  /// {@template flutter.material.appbar.backgroundColor}
  /// The fill color to use for an app bar's [Material].
  ///
  /// If null, then the [AppBarTheme.backgroundColor] is used. If that value is also
  /// null, then [AppBar] uses the overall theme's [ColorScheme.primary] if the
  /// overall theme's brightness is [Brightness.light], and [ColorScheme.surface]
  /// if the overall theme's brightness is [Brightness.dark].
  ///
  /// If this color is a [MaterialStateColor] it will be resolved against
  /// [MaterialState.scrolledUnder] when the content of the app's
  /// primary scrollable overlaps the app bar.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [foregroundColor], which specifies the color for icons and text within
  ///    the app bar.
  ///  * [Theme.of], which returns the current overall Material theme as
  ///    a [ThemeData].
  ///  * [ThemeData.colorScheme], the thirteen colors that most Material widget
  ///    default colors are based on.
  ///  * [ColorScheme.brightness], which indicates if the overall [Theme]
  ///    is light or dark.
  final Color? backgroundColor;

  /// {@template flutter.material.appbar.foregroundColor}
  /// The default color for [Text] and [Icon]s within the app bar.
  ///
  /// If null, then [AppBarTheme.foregroundColor] is used. If that
  /// value is also null, then [AppBar] uses the overall theme's
  /// [ColorScheme.onPrimary] if the overall theme's brightness is
  /// [Brightness.light], and [ColorScheme.onSurface] if the overall
  /// theme's brightness is [Brightness.dark].
  ///
  /// This color is used to configure [DefaultTextStyle] that contains
  /// the toolbar's children, and the default [IconTheme] widgets that
  /// are created if [iconTheme] and [actionsIconTheme] are null.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [backgroundColor], which specifies the app bar's background color.
  ///  * [Theme.of], which returns the current overall Material theme as
  ///    a [ThemeData].
  ///  * [ThemeData.colorScheme], the thirteen colors that most Material widget
  ///    default colors are based on.
  ///  * [ColorScheme.brightness], which indicates if the overall [Theme]
  ///    is light or dark.
  final Color? foregroundColor;

  /// {@template flutter.material.appbar.iconTheme}
  /// The color, opacity, and size to use for toolbar icons.
  ///
  /// If this property is null, then a copy of [ThemeData.iconTheme]
  /// is used, with the [IconThemeData.color] set to the
  /// app bar's [foregroundColor].
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [actionsIconTheme], which defines the appearance of icons in
  ///    the [actions] list.
  final IconThemeData? iconTheme;

  /// {@template flutter.material.appbar.actionsIconTheme}
  /// The color, opacity, and size to use for the icons that appear in the app
  /// bar's [actions].
  ///
  /// This property should only be used when the [actions] should be
  /// themed differently than the icon that appears in the app bar's [leading]
  /// widget.
  ///
  /// If this property is null, then [AppBarTheme.actionsIconTheme] of
  /// [ThemeData.appBarTheme] is used. If that is also null, then the value of
  /// [iconTheme] is used.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [iconTheme], which defines the appearance of all of the toolbar icons.
  final IconThemeData? actionsIconTheme;

  /// {@template flutter.material.appbar.primary}
  /// Whether this app bar is being displayed at the top of the screen.
  ///
  /// If true, the app bar's toolbar elements and [bottom] widget will be
  /// padded on top by the height of the system status bar. The layout
  /// of the [flexibleSpace] is not affected by the [primary] property.
  /// {@endtemplate}
  final bool primary;

  /// {@template flutter.material.appbar.centerTitle}
  /// Whether the title should be centered.
  ///
  /// If this property is null, then [AppBarTheme.centerTitle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, then value is
  /// adapted to the current [TargetPlatform].
  /// {@endtemplate}
  final bool? centerTitle;

  /// {@template flutter.material.appbar.excludeHeaderSemantics}
  /// Whether the title should be wrapped with header [Semantics].
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool excludeHeaderSemantics;

  /// {@template flutter.material.appbar.titleSpacing}
  /// The spacing around [title] content on the horizontal axis. This spacing is
  /// applied even if there is no [leading] content or [actions]. If you want
  /// [title] to take all the space available, set this value to 0.0.
  ///
  /// If this property is null, then [AppBarTheme.titleSpacing] of
  /// [ThemeData.appBarTheme] is used. If that is also null, then the
  /// default value is [NavigationToolbar.kMiddleSpacing].
  /// {@endtemplate}
  final double? titleSpacing;

  /// {@template flutter.material.appbar.toolbarOpacity}
  /// How opaque the toolbar part of the app bar is.
  ///
  /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
  ///
  /// Typically, this value is not changed from its default value (1.0). It is
  /// used by [SliverAppBar] to animate the opacity of the toolbar when the app
  /// bar is scrolled.
  /// {@endtemplate}
  final double toolbarOpacity;

  /// {@template flutter.material.appbar.bottomOpacity}
  /// How opaque the bottom part of the app bar is.
  ///
  /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
  ///
  /// Typically, this value is not changed from its default value (1.0). It is
  /// used by [SliverAppBar] to animate the opacity of the toolbar when the app
  /// bar is scrolled.
  /// {@endtemplate}
  final double bottomOpacity;

  /// {@template flutter.material.appbar.toolbarHeight}
  /// Defines the height of the toolbar component of an [AppBar].
  ///
  /// By default, the value of [toolbarHeight] is [kToolbarHeight].
  /// {@endtemplate}
  final double? toolbarHeight;

  /// {@template flutter.material.appbar.leadingWidth}
  /// Defines the width of [leading] widget.
  ///
  /// By default, the value of [leadingWidth] is 56.0.
  /// {@endtemplate}
  final double? leadingWidth;

  /// {@template flutter.material.appbar.toolbarTextStyle}
  /// The default text style for the AppBar's [leading], and
  /// [actions] widgets, but not its [title].
  ///
  /// If this property is null, then [AppBarTheme.toolbarTextStyle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the default
  /// value is a copy of the overall theme's [TextTheme.bodyMedium]
  /// [TextStyle], with color set to the app bar's [foregroundColor].
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [titleTextStyle], which overrides the default text style for the [title].
  ///  * [DefaultTextStyle], which overrides the default text style for all of the
  ///    widgets in a subtree.
  final TextStyle? toolbarTextStyle;

  /// {@template flutter.material.appbar.titleTextStyle}
  /// The default text style for the AppBar's [title] widget.
  ///
  /// If this property is null, then [AppBarTheme.titleTextStyle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the default
  /// value is a copy of the overall theme's [TextTheme.titleLarge]
  /// [TextStyle], with color set to the app bar's [foregroundColor].
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [toolbarTextStyle], which is the default text style for the AppBar's
  ///    [title], [leading], and [actions] widgets, also known as the
  ///    AppBar's "toolbar".
  ///  * [DefaultTextStyle], which overrides the default text style for all of the
  ///    widgets in a subtree.
  final TextStyle? titleTextStyle;

  /// {@template flutter.material.appbar.systemOverlayStyle}
  /// Specifies the style to use for the system overlays (e.g. the status bar on
  /// Android or iOS, the system navigation bar on Android).
  ///
  /// If this property is null, then [AppBarTheme.systemOverlayStyle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, an appropriate
  /// [SystemUiOverlayStyle] is calculated based on the [backgroundColor].
  ///
  /// The AppBar's descendants are built within a
  /// `AnnotatedRegion<SystemUiOverlayStyle>` widget, which causes
  /// [SystemChrome.setSystemUIOverlayStyle] to be called
  /// automatically. Apps should not enclose an AppBar with their
  /// own [AnnotatedRegion].
  /// {@endtemplate}
  //
  /// See also:
  ///
  ///  * [AnnotatedRegion], for placing [SystemUiOverlayStyle] in the layer tree.
  ///  * [SystemChrome.setSystemUIOverlayStyle], the imperative API for setting
  ///    system overlays style.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// {@template flutter.material.appbar.forceMaterialTransparency}
  /// Forces the AppBar's Material widget type to be [MaterialType.transparency]
  /// (instead of Material's default type).
  ///
  /// This will remove the visual display of [backgroundColor] and [elevation],
  /// and affect other characteristics of the AppBar's Material widget.
  ///
  /// Provided for cases where the app bar is to be transparent, and gestures
  /// must pass through the app bar to widgets beneath the app bar (i.e. with
  /// [Scaffold.extendBodyBehindAppBar] set to true).
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool forceMaterialTransparency;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  const ContextualAppBar({
    super.key,
    required this.counterBuilder,
    required this.contextualActions,
    this.automaticallyImplyLeading = true,
    this.closeIcon = Icons.close,
    this.leadingWidth,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsController<T>>(
      builder: (BuildContext context, ItemsController<T> value, Widget? child) {
        return AppBar(
          leading: IconButton(
            icon: Icon(closeIcon),
            onPressed: () {
              ActionMode.disable<T>(context);
            },
          ),
          elevation: elevation,
          automaticallyImplyLeading: automaticallyImplyLeading,
          surfaceTintColor: surfaceTintColor,
          foregroundColor: foregroundColor,
          centerTitle: centerTitle,
          bottom: bottom,
          backgroundColor: backgroundColor,
          clipBehavior: clipBehavior,
          actionsIconTheme: actionsIconTheme,
          bottomOpacity: bottomOpacity,
          excludeHeaderSemantics: excludeHeaderSemantics,
          flexibleSpace: flexibleSpace,
          actions: contextualActions,
          title: counterBuilder(value.items.length),
          forceMaterialTransparency: forceMaterialTransparency,
          iconTheme: iconTheme,
          leadingWidth: leadingWidth,
          notificationPredicate: notificationPredicate,
          primary: primary,
          scrolledUnderElevation: scrolledUnderElevation,
          shadowColor: shadowColor,
          shape: shape,
          systemOverlayStyle: systemOverlayStyle,
          titleSpacing: titleSpacing,
          titleTextStyle: titleTextStyle,
          toolbarHeight: toolbarHeight,
          toolbarOpacity: toolbarOpacity,
          toolbarTextStyle: toolbarTextStyle,
        );
      },
    );
  }
}
