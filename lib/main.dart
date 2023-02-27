import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/pages/home.dart';
import 'package:rickandmorty/riverpod/count.dart';
import 'package:rickandmorty/routes/routes.dart';
import 'package:rickandmorty/widget/menu.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRoutes.routes,
      title: 'Flutter Demo',
      onGenerateInitialRoutes: (initialRoute) {
        return [MaterialPageRoute(builder: (_) => const Home())];
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  static const routeName = '/';
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    int count = ref.watch(countProvider);
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.title), backgroundColor: Colors.lightGreen),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          ref.read(countProvider.notifier).increment(),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
