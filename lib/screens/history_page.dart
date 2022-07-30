import 'package:flutter/material.dart';
import 'package:pet_adoption_app_task/models/constants.dart';
import 'package:pet_adoption_app_task/models/pet_details_model.dart';
import 'package:provider/provider.dart';

import '../provider/pet_details_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PetDetailsProvider>(
        builder: (context, petProvider, _) {
          List<PetDetails> adoptedPets = petProvider.adoptedPets();
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'History 🗓️',
                  style: headlineTextStyle,
                ),
              ),
              const Divider(),

              // List of adopted pets
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: adoptedPets.length,
                  itemBuilder: (context, index) {
                    return Consumer<PetDetailsProvider>(
                      builder: (context, petProvider, _) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              adoptedPets[index].image.toString(),
                            ),
                          ),
                          title: Text(
                            adoptedPets[index].name.toString(),
                          ),
                          subtitle: Text(
                            '${adoptedPets[index].type} | Date: ${adoptedPets[index].adoptedAt!.day}/${adoptedPets[index].adoptedAt!.month}/${adoptedPets[index].adoptedAt!.year}',
                          ),
                          // trailing: Text(
                          //   '₹ 100',
                          //   style: priceTextStyle.copyWith(fontSize: 20),
                          // ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
