

import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_ticketing/dashboard.dart';
import 'package:mobile_ticketing/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'model/Album.dart';
import 'model/User.dart';

Future<String> login(TextEditingController login, TextEditingController password) async {
  final response = await http.post(
    Uri.parse('http://192.168.0.109:8080/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'login': login.text,
      'password': password.text
    }),
  );


  print("${response.statusCode}");
  print("${response.body}");
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Map<String, dynamic> decode_options = jsonDecode(response.body);
    String user = jsonEncode(User.fromJson(decode_options));
    return user;
    // shared_User.setString('user', user);
    //
    // User user = User.fromJson(jsonDecode(response.body));

    return user;
  } else {
    return '';
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPage> {
  late Future<Album> futureAlbum;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _storeLoginInfo(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
    prefs.setInt('isLogin', 1);
    print(prefs.toString());
  }



  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blueAccent, //change your color here
        ),
        leading: Icon(Icons.keyboard_arrow_left),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Container(
                  width: 50,
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset('Assets/youtube.png'),
                ),
                Center(
                    child: Text('Login In Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
                ),
                Center(
                  child: Text('Kindly Login to continue using our app', style: TextStyle(fontSize: 13, color: Colors.grey[600]),),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80, left: 40, right: 40 ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username Field must not be empty';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Field must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(),
                            contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),

                            suffixIcon: GestureDetector(
                              onTap: () {
                                _togglevisibility();
                              },
                              child: Container(
                                height: 50,
                                width: 70,
                                padding: EdgeInsets.symmetric(vertical: 13),
                                child: Center(
                                  child: Text(
                                    _showPassword ? "Hide" : "Show",
                                    style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: FlatButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              print("Forgot Passworda Clicked",);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: FlatButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Text('Login'),
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textColor: Colors.white,
                            onPressed: () async {
                              String userData = await login(usernameController, passwordController);
                              if (userData != '') {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Berhasil!')));
                                await _storeLoginInfo(userData);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (_) => Dashboard()));

                              } else  {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username dan Password Salah!')));
                              }
                              print('Logged In');
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(title: "Register")));
                        },
                        child: Container(
                          padding: EdgeInsets.all(30),
                          child: Text('Do not have an Account? SignUp'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
                        child: Text('or connect with'),
                      ),
                      Container(
                        padding: EdgeInsets.only( left: 30, right: 30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('Assets/facebook.png'),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage('Assets/google.png'),
                                ),
                              ),
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('Assets/twitter.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}