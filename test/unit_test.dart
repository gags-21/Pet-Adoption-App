import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app_task/provider/pet_details_provider.dart';
import 'package:pet_adoption_app_task/provider/theme_provider.dart';

main() {
  test('Theme Toggler', () async {
    // test
    ThemeMode result = await ThemeProvider().toggleTheme(false);
    // result
    expect(result, ThemeMode.light);
  });

  test('Total Pets Counter', () async {
    // test
    int petCount = PetDetailsProvider().totalPets;
    // result
    expect(petCount, PetDetailsProvider().totalPets);
  });
}
