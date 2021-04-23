import 'package:flutter/material.dart';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/services/services.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';
import 'package:flutter_bolierplate_example/widgets/widgets.dart';

class PhoneInput extends StatefulWidget {
  final String labelText;
  final String phoneNumber;
  final Function(String, String) onSaved;
  final EdgeInsets padding;
  final Color fillColor;
  final Function(String) validator;

  const PhoneInput({
    Key key,
    this.validator,
    @required this.labelText,
    this.phoneNumber,
    @required this.onSaved,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 5,
    ),
    this.fillColor,
  }) : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  TextEditingController _controller = TextEditingController();
  Country _selectedCountry = countries.where((country) {
    return country.codeShort == "TH";
  }).first;

  Future<void> _selectCountry() async {
    Country selectedCountry = await locator<NavigationService>().push(
      CountriesView(),
      fullscreenDialog: true,
    );

    if (selectedCountry != null) {
      this.setState(() {
        _selectedCountry = selectedCountry;
      });
    }
  }

  void _onSaved(String number) {
    String formalisedNumber = "${_selectedCountry.dialCode}$number";

    FlutterLibphonenumber().parse(formalisedNumber).then((result) {
      this.widget.onSaved(result["national"], result['country_code']);
    });
  }

  @override
  void initState() {
    if (this.widget.phoneNumber?.isNotEmpty ?? false) {
      FlutterLibphonenumber()
          .parse(this.widget.phoneNumber.toString())
          .then((result) {
        List<Country> filteredCountry = countries?.where((country) {
          return country.dialCode == "+${result["country_code"]}";
        })?.toList();

        this.setState(() {
          if (filteredCountry?.isNotEmpty ?? false) {
            _controller.text = result["national_number"];
            _selectedCountry = filteredCountry.first;
          } else {
            _selectedCountry = countries.where((country) {
              return country.codeShort == "TH";
            }).first;
          }
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 5;

    return Padding(
      padding: this.widget.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: _selectCountry,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  color: this.widget.fillColor ?? Colors.grey[200],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SmartImage.asset(
                          assetPath:
                              "assets/flags/${_selectedCountry.codeShort.toLowerCase()}.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Input(
              fillColor: this.widget.fillColor,
              prefixText: _selectedCountry.dialCode,
              padding: const EdgeInsets.all(0),
              controller: _controller,
              keyboardType: TextInputType.phone,
              labelText: this.widget.labelText,
              onSaved: _onSaved,
              validator: Validator.phone,
            ),
          ),
        ],
      ),
    );
  }
}
