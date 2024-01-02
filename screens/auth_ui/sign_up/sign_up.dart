// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projcet_canhan/constants/constants.dart';
import 'package:projcet_canhan/constants/routes.dart';
import 'package:projcet_canhan/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:projcet_canhan/screens/home/home.dart';
import 'package:projcet_canhan/widgets/primary_button/primary_button.dart';
import 'package:projcet_canhan/widgets/top_titles/top_titles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool inShowPassword = true;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitlles(
                subtitle: "Chào Mừng Bạn Đến Với Tôi", title: "Tạo Tài Khoản"),
                const SizedBox(
                  height: 46.0,
                  ),
                  TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Phone",
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: password,
                  obscureText: inShowPassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.password_sharp,
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: (){
                        setState(() {
                          inShowPassword = !inShowPassword;         
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.visibility,
                      color: Colors.grey,
                      )),
                  ),
                ),
                const SizedBox(
                  height: 36.0,
                ),
                PrimaryButton(
                  title: "Tạo Tài Khoản",
                  onPressed: () async {
                   bool isVaildated = signUpValidation(
                    email.text, password.text, name.text, phone.text);
              if(isVaildated) {
              bool isLogined = await  FirebaseAuthHelper.instance
                   .signUp(email.text, password.text, context);
              if (isLogined) {
                Routes.instance.pushAndRemoveUntil(
                  widget: const Home(), context: context);
              }
              }
                  },
                ),
                 const SizedBox(
                  height: 24.0,
                ),
                const Center(child: Text("Tôi Đã Có Tài Khoản?")),
                const SizedBox(
                  height: 12.0,
                ),
                Center(
                child: CupertinoButton(
                onPressed: (){
                  Navigator.of(context).pop();                  
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor
                   ),
                 ), 
               ),
             ),
        
            ],
          ),
        ),
      ),
    );
  }
}
