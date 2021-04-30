import 'package:flutter_bolierplate_example/providers/countries/countries.dart';
import 'package:flutter_bolierplate_example/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _countriesRepository =
    ChangeNotifierProvider.autoDispose<CountriesRepository>((ref) {
  return CountriesRepository();
});

class CountriesView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(_countriesRepository);

    return Scaffold(
      appBar: AppBar(
        title: SearchField(
          autoFocus: false,
          hintText: 'เลือกประเทศโทรศัพท์',
          controller: model.searchController,
        ),
      ),
      body: Scrollbar(
        child: ListView.separated(
          itemCount: model.filteredCountries.length,
          itemBuilder: (context, index) {
            return Material(
              color: Colors.white,
              child: BaseTile(
                onTap: () => model.selectCountry(
                  model.filteredCountries[index],
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SmartImage.asset(
                    width: 50,
                    height: 50,
                    assetPath:
                        "assets/flags/${model.filteredCountries[index].codeShort.toLowerCase()}.png",
                  ),
                ),
                topLeft: Text(
                  model.filteredCountries[index].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                middleLeft: Text(
                  model.filteredCountries[index].dialCode,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Line();
          },
        ),
      ),
    );
  }
}
