import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/services/services.dart';

class CountriesRepository extends ChangeNotifier {
  // services
  final NavigationService _navigator = locator<NavigationService>();

  // states
  TextEditingController searchController = TextEditingController();

  // constructor
  CountriesRepository() {
    searchController.addListener(() {
      _filteredCountries = countries.where((country) {
        bool sameName = country.name.contains(searchController.text);

        return sameName;
      }).toList();
      notifyListeners();
    });
  }

  List<Country> _filteredCountries = countries;
  List<Country> get filteredCountries => _filteredCountries;

  // methods
  void selectCountry(Country country) {
    _navigator.pop(country);
  }
}
