import 'package:flutter/material.dart';
import 'dart:math';

/// Flutter code sample for [TabBar].

void main() => runApp(const TabBarApp());

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Primary and secondary TabBar'),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                text: 'Flights',
                icon: Icon(Icons.flight),
              ),
              Tab(
                text: 'Trips',
                icon: Icon(Icons.luggage),
              ),
              Tab(
                text: 'Explore',
                icon: Icon(Icons.explore),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            NestedTabBar('Flights'),
            NestedTabBar('Trips'),
            NestedTabBar('Explore'),
          ],
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  var randomWidth = 0;
  var randomHeight = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setRandomSizes(MediaQuery.of(context).size.width);
  }

  void setRandomSizes(double screenWidth) {
    const freeSpace = 100;
    final size = screenWidth - freeSpace;

    randomWidth = size.floor() - freeSpace ~/ 2 + Random().nextInt(freeSpace);
    randomHeight = size.floor() - freeSpace ~/ 2 + Random().nextInt(freeSpace);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://picsum.photos/$randomWidth/$randomHeight';

    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Overview'),
            Tab(text: 'Specifications'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              GestureDetector(
                onHorizontalDragEnd: (_) {
                  setState(() {
                    setRandomSizes(MediaQuery.of(context).size.width);
                  });
                },
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.outerTab}: Overview tab'),
                        Image.network(imageUrl, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onHorizontalDragEnd: (_) {
                  setState(() {
                    setRandomSizes(MediaQuery.of(context).size.width);
                  });
                },
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.outerTab}: Specifications tab'),
                        Image.network(imageUrl, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}