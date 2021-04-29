import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/src/saved.dart';

import 'bloc/Bloc.dart';

class RandomList extends StatefulWidget {
  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Naming App"),
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SavedList()));
            }),
          ],
        ),
        body: StreamBuilder<Set<WordPair>>(
          stream: bloc.savedStream,
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index.isOdd) return Divider();
                var realIndex = index ~/ 2;
                if (realIndex >= _suggestions.length)
                  _suggestions.addAll(generateWordPairs().take(10));
                return _buildRow(snapshot.data,_suggestions[realIndex]);
              },
            );
          }
        ));
  }

  Widget _buildRow(Set<WordPair> saved, WordPair word) {
    final bool alreadySaved = saved==null?false:saved.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
          alreadySaved?Icons.favorite:Icons.favorite_border,
          color: alreadySaved?Colors.redAccent:Colors.grey,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(word);
      },
    );
  }
}
