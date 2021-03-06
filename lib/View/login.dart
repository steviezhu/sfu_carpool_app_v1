import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sfucarpoolapp/Controller/auth.dart';
import 'package:sfucarpoolapp/View/forgetPwd.dart';


class LogIn extends StatefulWidget {
  final Function toggleView;
  LogIn({this.toggleView}); //constructor call

  @override
  State<StatefulWidget> createState() => LogInPage();
}

class LogInPage extends State<LogIn> {
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Login'),
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('SFU',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Roboto',
                          color: Colors.white)),
                  Text('Carpool\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                   // validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                   // key: _formKey,
                  //  controller: usernameText,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                   // key: _formKey,
                //    controller: passwordText,
                    obscureText: true,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                    textColor: Colors.white,
                    onPressed: () async {
                      dynamic result = await _auth.logInWithEmailAndPassword(email, password);
                       if(result == null) {
                         setState(() {
                           error = 'could not log in with those credentials';
                         });
                       }
                       else if(result == false){
                         // TODO: same as sign up one. -C
                         return showDialog<void>(
                             context: context,
                             barrierDismissible: false,
                             builder: (BuildContext context) {
                               return AlertDialog(
                                   title: Text("Reminder"),
                                   content: SingleChildScrollView(
                                     child: ListBody(
                                       children: <Widget>[
                                         Text(
                                             'Please Check your Email Inbox to Activate your Account.'),
                                       ],
                                     ),
                                   ),
                                   actions: <Widget>[
                                     FlatButton(
                                       child: Text('OK'),
                                       onPressed: () {
                                         Navigator.of(context).pop();
                                       },
                                     )
                                   ]
                               );
                             }
                         );
                      }
                    }
                  ),
                  FlatButton(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ForgetPwd()));
                    },
                  ),
                  SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
