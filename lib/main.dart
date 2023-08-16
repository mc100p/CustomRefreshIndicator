import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pulledDownActivated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels <= -130 &&
              notification.metrics.atEdge == false) {
            showCustomRefreshScreen();
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Colors.red,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                "Items",
              )),
            ),
            SliverToBoxAdapter(
              child: pulledDownActivated
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: customCircularProgressIndicator(),
                    )
                  : Container(),
            ),
            SliverList.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index'),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future showCustomRefreshScreen() async {
    setState(() {
      pulledDownActivated = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      pulledDownActivated = false;
    });
  }

  Widget customCircularProgressIndicator() {
    return const Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 2,
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "S",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
          ),
        ),
      ],
    );
  }
}
