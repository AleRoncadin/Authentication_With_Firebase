import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roncadin_app/widgets/textdisplay.dart';
import 'GoogleAuthentication.dart';
import 'main.dart';
import 'widgets/buildTitle.dart';
import 'widgets/button.dart';

class ProfileScreen extends StatefulWidget {
  final uid;
  final mail;
  const ProfileScreen({ Key? key, required this.uid, required this.mail}): super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

    void logout() async{
      try{
        await FirebaseAuth.instance.signOut(); //disconnette l'utente
        await GoogleAuthentication.signOut(context: context); //se l'utente si è autenticato con Google avviene il signOut di Google
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage())); //torna alla schermata iniziale
      } on FirebaseAuthException catch (e) { 
          showDialog( //in caso di errori, viene mostrato al centro della schermata un messaggio di errore
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Logout Failed"),
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
    }

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid.toString();
    String mail = widget.mail.toString();

    print(uid);

    return Scaffold(
      appBar: AppBar(title: buildTitle(myText: 'HOME',), backgroundColor: Colors.black,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextDisplay(myText: "Logged: $mail", fontSize: 14, fontWeight: FontWeight.normal, textAlign: TextAlign.left, color: Colors.white, textColor: Colors.black),
          const SizedBox(
              height: 400.0,
            ),
          Button(selectHandler: () => logout(), buttonText: "Logout", color_text: Colors.white, background_color: Colors.black),
          ],
          ),
        ),
    );
  }
}