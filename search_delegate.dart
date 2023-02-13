import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchDelegate extends SearchDelegate{

  List<String> searchTerms = [
    'Japan',
    'United State of America',
    'Vietnam',
    'India',
    'Korea',
    'Jordan',
    'France',
    'United Kingdom',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          icon: const Icon(Icons.clear),
        onPressed: (){
            query ='';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          close(context,null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var country in searchTerms){
      if(country.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(country);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result = matchQuery[index];
        return ListTile(
          title: Center(child: Text(result,
            style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 25.0),)),
          tileColor: Colors.orangeAccent,
          leading: const Icon(Icons.place),
          onTap: () => context.push('/details?states=$result'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var country in searchTerms){
      if(country.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(country);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          leading: const Icon(Icons.place),
          onTap: () => context.push('/details?states=$result'),
        );
      },
    );
  }
  
}