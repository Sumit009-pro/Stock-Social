import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_material_button.dart';

import '../../models/api.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  _ChangePhoneNumberState createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  UserModel? userDetails;

  final _formKey = GlobalKey<FormState>();

  final _phonenumberController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
    print(userDetails);
  }

  onSubmit() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSpinner(context, "Please wait...");
      final response = await API.updateUserPhone(_phonenumberController.text);
      hideLoadingSpinner(context);

      // obtain shared preferences
      if (response["STATUSCODE"] == 200) {
        // obtain shared preferences
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text("Please fix errors"))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height

          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            centerTitle: true,
            title: Text(
              'Profile',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(0XFFFFFFFF),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: (30 / 24),
                fontFamily: "Roboto",
              ),
            ),
            elevation: 0,
            actions: [
              new Stack(
                children: <Widget>[
                  new IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Color(0XFFE5E5E5),
                      ),
                      onPressed: () {}),
                  new Positioned(
                    right: 11,
                    top: 11,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '5',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              new IconButton(
                  icon: Icon(
                    Icons.mail,
                    color: Color(0XFFE5E5E5),
                    size: 22,
                  ),
                  onPressed: () {}),
            ],
          )),
      body: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'How do you want to change your phone?',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0XFFE5E5E5),
                        child: const Text('SK'),
                      ),
                      title: Text("${userDetails?.firstName} ${userDetails?.lastName}",
                        //'Profile Name',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      subtitle: Text(
                        userDetails?.email ?? "",
                        //'profilename@info.com',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 12),
                      child: Text(
                        'Please update your new phone number, ensure that its different from the old one',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: (22 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                  exclude: <String>['KN', 'MF'],
                                  //Optional. Shows phone code before the country name.
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    setState(() {
                                      _countryController.text =
                                          country.phoneCode;
                                    });
                                    print(
                                        'Select country: ${country.phoneCode}');
                                  },
                                  // Optional. Sets the theme for the country list picker.
                                  countryListTheme: CountryListThemeData(
                                    // Optional. Sets the border radius for the bottomsheet.
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                    // Optional. Styles the search field.
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search',
                                      hintText: 'Start typing to search',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8)
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              controller: _countryController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                border: UnderlineInputBorder(),
                                labelText: 'Country',
                                labelStyle: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: (15 / 12),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 210,
                            child: TextFormField(
                              controller: _phonenumberController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: (15 / 12),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (!RegExp("^(?:[+0]9)?[0-9]{10,12}")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    MyMaterialButton(tittle: ' Save', onTap: onSubmit),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
