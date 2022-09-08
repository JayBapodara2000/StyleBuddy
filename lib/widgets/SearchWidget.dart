import 'package:flutter/material.dart';
import 'package:style_buddy/pages/SignupScreen.dart';

class styleMasterSearch extends SearchDelegate<String> {
  late final List<String> entityNameList;

  styleMasterSearch(this.entityNameList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => SignupScreen()),
              ));
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = entityNameList.where((username) {
      return username.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions.elementAt(index)),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = entityNameList.where((username) {
      return username.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions.elementAt(index)),
          );
        });
  }
}
