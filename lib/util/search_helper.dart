import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pet_details_provider.dart';
import '../screens/details_page.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query == '') {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    final petProvider = Provider.of<PetDetailsProvider>(context);
    List petNames = petProvider.petNamesList();
    return Center(
      child: Text(petNames.contains(query) ? '' : 'No Results'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final petProvider = Provider.of<PetDetailsProvider>(context);

    // Taking pet names in list
    List petNames = petProvider.petNamesList();
    List name = [
      for (int i = 0; i < petNames.length; i++)
        if (petNames[i].toString().toLowerCase().contains(query.toLowerCase()))
          petNames[i]
    ];

    // Returning suggestions based on user input
    return ListView.builder(
      itemCount: name.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          key: const Key('searchResults'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              petProvider
                  .petDetails(petNames.indexOf(name[index]))
                  .image
                  .toString(),
            ),
          ),
          title: Text(name[index]),
          onTap: () {
            showResults(context);
            petProvider.petName(index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  index: petNames.indexOf(name[index]),
                  pet: petProvider.petDetails(petNames.indexOf(name[index])),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
