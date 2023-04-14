import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yigi/login/sifre.dart';

import 'package:yigi/pages/main_page.dart';


import 'const.dart';
import 'kayıt.dart';


class Login2 extends StatelessWidget {
  const Login2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "GİRİŞ YAP",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email Adresi",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Lütfen bir email adresi giriniz";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Şifre",
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Lütfen bir şifre giriniz";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SifremiUnuttum()),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Şifremi Unuttum",
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (Form.of(context)!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                },
                child: Text(
                  "Giriş Yap",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Hesabın yok mu? ",
                    style: Theme.of(context).textTheme.bodyLarge!,
                    children: [
                      TextSpan(
                        text: "Kayıt Ol",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  ElevatedButton.icon(
                    onPressed: () async {
                      // Google ile giriş yapmak için kullanıcıyı doğrulama ekranına yönlendirin
                      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                      if (googleUser == null) return;

                      // Google kullanıcısını Firebase Authentication ile doğrulayın
                      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                      final OAuthCredential credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );
                      await FirebaseAuth.instance.signInWithCredential(credential);

                      // Ana sayfaya yönlendirin
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                      );
                    },
                    icon: const Icon(Icons.g_mobiledata),
                    label: Text(
                      "Google ile Giriş Yap",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Facebook ile giriş yapmak için kullanıcıyı doğrulama ekranına yönlendirin
                      final LoginResult result = await FacebookAuth.instance.login();
                      if (result.status != LoginStatus.success) return;

                      // Facebook kullanıcısını Firebase Authentication ile doğrulayın
                      final AccessToken accessToken = result.accessToken!;
                      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
                      await FirebaseAuth.instance.signInWithCredential(credential);

                      // Ana sayfaya yönlendirin
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                      );
                    },
                    icon: const Icon(Icons.facebook),
                    label: Text(
                      "Facebook ile Giriş Yap",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4267B2),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                child: Text(
                  "Üye Olmadan Devam Et",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),

                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: kPrimaryColor,
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
