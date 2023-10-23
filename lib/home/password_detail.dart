import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sitelerim/constants/app_navigator.dart';

import '../constants/app_constants.dart';
import '../models/password.dart';
import '../widgets/app_container.dart';

class PasswordDetail extends StatefulWidget {
  const PasswordDetail({Key? key}) : super(key: key);

  static const String routeName = '/password-detail';

  @override
  State<PasswordDetail> createState() => _PasswordDetailState();
}

class _PasswordDetailState extends State<PasswordDetail> {
  var passwordName = "";
  Password? password;
  bool _obscureText = true;

  @override
  void didChangeDependencies() {
    var passwordString = ModalRoute.of(context)?.settings.arguments as String;

    var passwordJson = jsonDecode(passwordString);

    setState(() {
      password = Password.fromJson(passwordJson);
      passwordName = password!.subNameUrl;
    });

    super.didChangeDependencies();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive resp = Responsive.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: resp.hp(8),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: paddingHor,
            child: _buildRowBackButton(resp, context),
          ),
          sizedBoxHeightLarge,
          AppContainer(
            width: resp.wp(80),
            height: resp.hp(6),
            child: Text(password!.topNameUrl, style: fontSFProMediumRed22),
          ),
          sizedBoxHeightMedium,
          AppContainer(
            width: resp.wp(80),
            height: resp.hp(6),
            child: Center(child: Text(password!.subNameUrl, style: fontSFProMediumOrange20)),
          ),
          sizedBoxHeightMedium,
          InkWell(
            onTap: _toggle,
            child: _obscureText
                ? AppContainer(
                    width: resp.wp(40),
                    height: resp.hp(6),
                    child: Center(
                      child: Center(child: Text(textView, style: fontSFProBoldGreen22)),
                    ),
                  )
                : AppContainer(
                    width: resp.wp(80),
                    height: resp.hp(8),
                    child: SelectableText(
                      password!.password,
                      style: fontSFProMediumBlue22,
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Expanded(
            child: Image.asset(
              imgPassword,
              width: resp.wp(60),
            ),
          ),
          sizedBoxHeightLarge,
        ],
      ),
    );
  }

  Row _buildRowBackButton(Responsive resp, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: resp.wp(11),
          height: resp.hp(5),
          decoration: BoxDecoration(
            borderRadius: borderRadiusLarge,
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: IconButton(
            onPressed: () => context.navigation.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }
}
