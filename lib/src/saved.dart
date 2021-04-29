import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';

import 'bloc/Bloc.dart';

class SavedList extends StatefulWidget {

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected"),
      ),
      body: StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          var saved = Set<WordPair>();
          if(snapshot.hasData)
            saved.addAll(snapshot.data);
          else
            bloc.addCurrentSaved;
          return ListView.builder(itemBuilder: (context,index){
            return ListTile(
              title: Text(snapshot.data.toList()[index].asPascalCase),
              onTap: (){
                bloc.addToOrRemoveFromSavedList(snapshot.data.toList()[index]);
              },
            );
          },itemCount: snapshot.data.length,);
        }
      ),
    );
  }
}
