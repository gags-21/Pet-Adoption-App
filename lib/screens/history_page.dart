import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_adoption_app_task/models/constants.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'History 🗓️',
              style: headlineTextStyle,
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/007/537/995/non_2x/dog-logo-cartoon-cute-pet-smile-puppy-mascot-wear-glasses-on-white-background-vector.jpg'),
                  ),
                  title: Text(
                    'Pet Name',
                  ),
                  subtitle: Text(
                    'Pet Type | Date: 28/07/2022',
                  ),
                  trailing: Text(
                    '₹ 100',
                    style: priceTextStyle.copyWith(fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
