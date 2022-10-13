import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(); bu birinci method firebase initializaapp i yazinca kaldirdik
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

final Future<FirebaseApp> _initialization=Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:
         FutureBuilder(
           future: _initialization,
           builder: (context,snapshot){
 if(snapshot.hasError){
   return Center(child: Text("something went wrong"),);
 }
 else if(snapshot.hasData){
   return const MyHomePage(title: 'Flutter Demo Home Page');
 }
 else {
   return Center(child:CircularProgressIndicator(),);
 }
           },
         )
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference testCollectionRef = FirebaseFirestore.instance.collection('numbers');
 testCollectionRef.add({'numbers':"$_counter"});
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
