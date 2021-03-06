import 'package:flutter/material.dart';
import 'package:techteam/component/custom_suffix_icon.dart';
import 'package:techteam/component/default_button.dart';
import 'package:techteam/component/form_error.dart';
import 'package:techteam/constrants.dart';
import 'package:techteam/screen/home/home_screen.dart';

import '../../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final List<String> errorsEmails = [];
  final List<String> errorPasswords = [];
  final List<Color> color = [
    Colors.white,
    Colors.white,
  ];
  bool? remember = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Email/Số điện thoại',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(15)),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            buildEmailFormField(),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            FormErrorEmails(errorsEmails: errorsEmails),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              'Mật khẩu',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            FormErrorPasswords(errorPasswords: errorPasswords),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: remember,
                  activeColor: kTitleTextColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),
                const Text('Nhớ đăng nhập'),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Navigator to ??
                  },
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      color: Color(0XFF4F4F4F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            DefaultButton(
              text: 'Tiếp tục',
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildEmailFormField() {
    return Container(
      decoration: BoxDecoration(
        color: color[0],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errorsEmails.contains(kEmailNullError)) {
            setState(() {
              errorsEmails.remove(kEmailNullError);
              color[0] = Colors.white;
            });
          } else if (emailValidatorRegExp.hasMatch(value) &&
              errorsEmails.contains(kInvalidEmailError)) {
            setState(
              () {
                errorsEmails.remove(kInvalidEmailError);
                color[0] = Colors.white;
              },
            );
          }
        },
        validator: (value) {
          if (value!.isEmpty && !errorsEmails.contains(kEmailNullError)) {
            setState(() {
              errorsEmails.add(kEmailNullError);
              color[0] = const Color(0XFFF9CECE);
            });
            return '';
          } else if (!emailValidatorRegExp.hasMatch(value) &&
              !errorsEmails.contains(kInvalidEmailError)) {
            setState(() {
              errorsEmails.add(kInvalidEmailError);
              color[0] = const Color(0XFFF9CECE);
            });
            return '';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'Email/Số điện thoại',
          enabledBorder: outLineInputEmailBorder(),
          focusedBorder: outLineInputEmailBorder(),
          errorStyle: const TextStyle(height: 0),
          errorBorder: outLineInputEmailBorder(),
          focusedErrorBorder: outLineInputEmailBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder outLineInputEmailBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color[0],
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Container buildPasswordFormField() {
    return Container(
      decoration: BoxDecoration(
        color: color[1],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: true,
        onSaved: (newValue) {
          password = newValue;
        },
        onChanged: (value) {
          if (value.isNotEmpty && errorPasswords.contains(kPassNullError)) {
            setState(() {
              errorPasswords.remove(kPassNullError);
              color[1] = Colors.white;
            });
          } else if (value.length >= 8 &&
              errorPasswords.contains(kShortPassError)) {
            setState(() {
              errorPasswords.remove(kShortPassError);
              color[1] = Colors.white;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty && !errorPasswords.contains(kPassNullError)) {
            setState(() {
              errorPasswords.add(kPassNullError);
              color[1] = const Color(0XFFF9CECE);
            });
            return '';
          } else if (value.length < 8 &&
              !errorPasswords.contains(kShortPassError)) {
            setState(() {
              errorPasswords.add(kShortPassError);
              color[1] = const Color(0XFFF9CECE);
            });
            return '';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'Mật khẩu',
          enabledBorder: outLineInputPasswordBorder(),
          focusedBorder: outLineInputPasswordBorder(),
          errorStyle: const TextStyle(height: 0),
          errorBorder: outLineInputPasswordBorder(),
          focusedErrorBorder: outLineInputPasswordBorder(),
          suffixIcon: const CustomSuffixIcon(
            svgIcon: 'assets/icons/visibility_24px.svg',
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outLineInputPasswordBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color[1],
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
