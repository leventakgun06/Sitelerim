import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitelerim/home/password_detail.dart';

import 'dart:convert';

import '../constants/app_constants.dart';
import '../models/password.dart';
import '../widgets/my_anim_search.dart';


class PasswordList extends StatefulWidget {
  const PasswordList({Key? key}) : super(key: key);

  static const String routeName = '/password-list';

  @override
  State<PasswordList> createState() => _PasswordListState();
}

class _PasswordListState extends State<PasswordList> {
  List<Password> allPassword = [];
  List<Password> filteredPassword = [];

  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString(loadString);
    final passwordData = await json.decode(response);

    var list = passwordData["items"] as List<dynamic>;

    setState(() {
      allPassword = [];
      allPassword = list.map((e) => Password.fromJson(e)).toList();
      filteredPassword = allPassword;
    });
  }

  void _runFilter(String searchKeyword) {
    List<Password> results = [];

    if (searchKeyword.isEmpty) {
      results = allPassword;
    } else {
      results = allPassword
          .where((element) => element.topNameUrl
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredPassword = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive resp = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: resp.hp(8),
        ),
        body: Column(
          children: [
            Padding(
              padding: paddingHor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildContainerDown(resp, context),
                  MyAnimSearchBar(onChanged: (text) => _runFilter(text)),
                ],
              ),
            ),
            sizedBoxHeightSmall,
            _buildContainer(resp, context),
            sizedBoxHeightSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filteredPassword.length,
                itemBuilder: (BuildContext context, index) {
                  return _buildCard(resp, context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildCard(Responsive resp, BuildContext context, int index) {
    return Card(
      margin: paddingAll,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
          borderRadius: borderRadiusLow),
      shadowColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: paddingAll,
        child: ListTile(
          dense: true,
          leading: Container(
            width: resp.wp(9),
            height: resp.hp(4),
            decoration: BoxDecoration(
              borderRadius: borderRadiusLarge,
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: Center(
              child: Text(filteredPassword[index].id.toString(),
                  style: fontSFProMedium16),
            ),
          ),
          title: Text(filteredPassword[index].topNameUrl,
              style: fontSFProMedium18),
          onTap: () {
            Navigator.of(context).pushNamed(PasswordDetail.routeName,
                arguments: jsonEncode(filteredPassword[index]));
          },
          trailing: const Icon(Icons.chevron_right, size: iconSmall),
        ),
      ),
    );
  }

  Container _buildContainerDown(Responsive resp, BuildContext context) {
    return Container(
      width: resp.wp(11),
      height: resp.hp(5),
      decoration: BoxDecoration(
        borderRadius: borderRadiusLarge,
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: IconButton(
        onPressed: readJsonFile,
        icon: Icon(
          Icons.arrow_downward,
          color: Theme.of(context).colorScheme.primary,
          size: iconSmall,
        ),
      ),
    );
  }

  Container _buildContainer(Responsive resp, BuildContext context) {
    return Container(
      width: resp.wp(60),
      height: resp.hp(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: radiusMedium,
          bottomLeft: radiusMedium,
        ),
        color: colorTransparent,
        border: Border.all(
            color: Theme.of(context).colorScheme.primary, width: 1.0),
      ),
      child: InkWell(
        onTap: readJsonFile,
          child: Center(child: Text(textWebHeader, style: fontSFProMedium22))),
    );
  }
}
