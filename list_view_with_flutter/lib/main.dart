import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:list_view_with_flutter/rick.dart';

void main() {
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<CharacterList> charactersList;

  @override
  void initState() {
    super.initState();
    charactersList = getCharacterList();
    //loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
        centerTitle: true,
      ),
      body: FutureBuilder<CharacterList>(
        future: charactersList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.characters.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data!.characters[index].name}'),
                      subtitle:
                          Text('${snapshot.data!.characters[index].gender}'),
                      leading: Image.network(
                          '${snapshot.data!.characters[index].image}'),
                      isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
