import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_query/character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _store = FirebaseFirestore.instance;

  // 取得したキャラクター群
  List<Character> characters = [];

  @override
  void initState() {
    super.initState();
  }

  /// すべてのキャラクターを取得する
  Future<void> fetchAllUser() async {
    final snap = await _store.collection("characters").get();
    characters = snap.docs.map((e) => Character.fromJson(e.data())).toList();
    setState(() {});
  }

  /// Firestore にキャラクター群を追加する
  Future<void> addCharacters() async {
    // 参考：http://www.sazaesan.jp/charactors.html
    List<Character> storeCharacters = [
      Character(name: 'フグ田サザエ', age: 24),
      Character(name: '磯野波平', age: 54),
      Character(name: '磯野フネ', age: 50),
      Character(name: 'フグ田マスオ', age: 28),
      Character(name: '磯野カツオ', age: 11),
      Character(name: '磯野ワカメ', age: 9),
      Character(name: 'フグ田タラオ', age: 3),
      Character(name: 'タマ', age: null),
    ];
    for (final character in storeCharacters) {
      await _store.collection('characters').add({
        'name': character.name,
        'age': character.age,
      });
    }
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
              'users',
            ),
            if (characters.isNotEmpty)
              Column(
                children: characters
                    .map((e) => ListTile(
                          title: Text('${e.name} : ${e.age}'),
                        ))
                    .toList(),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await fetchAllUser();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
