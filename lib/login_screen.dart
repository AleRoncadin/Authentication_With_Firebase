import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'GoogleAuthentication.dart';
import 'profile_screen.dart';
import 'register_screen.dart';
import 'widgets/buildTitle.dart';
import 'widgets/button.dart';
import 'widgets/textField.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //funzione per il login denominata loginUsingEmailPassword
  Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async
    //due variabili stringhe: una per la email e una per la password
    {
      User? user; //istanza di User
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //istanza di Firebase Auth
      final db = FirebaseDatabase(databaseURL: "https://roncadin-application-default-rtdb.europe-west1.firebasedatabase.app/")
        .reference().child("Users"); //istanza di Firebase Realtime Database

    try 
    {
      //per accedere, è chiamato il metodo signInWithEmailAndPassword(), con il quale vengono richieste email e password
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

    } on FirebaseAuthException catch (e) { //in caso di errori, viene mostrato al centro della schermata un messaggio di errore

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Login Failed"),
          content: Text('${e.message}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {

    //vengono dichiarati due TextEditingController per email e password che vengono inserite nelle due TextField (righe 151 e 165)
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    User? user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[buildTitle(myText: "Login")],
              ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            child: Image.asset('assets/logo.png'),
          ),
          const SizedBox(
            height: 30.0,
          ),
          textfield(myText: "Email", textEditingController: _emailController, textInputType: TextInputType.emailAddress, icon: Icons.mail, obscureText: false),
          const SizedBox(
            height: 44.0,
          ),
          textfield(myText: "Password", textEditingController: _passwordController, textInputType: TextInputType.visiblePassword, icon: Icons.lock, obscureText: true,),
          const SizedBox(
            height: 50.0,
          ),
          Button( //LOGIN BUTTON
            selectHandler: () async {
              user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
              String? us_mail = user?.email;
              String? uid = user?.uid;
              print("Email: $us_mail, ID: $uid");
              if (user != null) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen(uid: uid, mail: us_mail,)));
              }
            }, 
            buttonText: "Login",
            color_text: Colors.black,
            background_color: Colors.red
          ),
          Button( //REGISTER BUTTON
            selectHandler: () async {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen())); //passa alla schermata RegisterScreen
            }, 
            buttonText: "Register",
            color_text: Colors.white,
            background_color: Colors.black
          ),
          Button( //SIGN IN WITH GOOGLE BUTTON
            selectHandler: () async {
                User? user = await GoogleAuthentication.signInWithGoogle(context: context); //viene richiamata la funzione signInWithGoogle appartente alla classe GoogleAuthentication
                String? us_mail = user?.email.toString();
                String? uid = user?.uid;
                print("Email: $us_mail, ID: $uid");
                if (user != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen(uid: uid, mail: us_mail,))); //passa alla schermata ProfileScreen
                }
              }, 
            buttonText: "Sign in With Google",
            color_text: Colors.white,
            background_color: Colors.black
          ),
        ],
      ),
    );
  }
}