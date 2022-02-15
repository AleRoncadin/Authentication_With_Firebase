import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

class GoogleAuthentication { 

  static Future<User?> signInWithGoogle({required BuildContext context}) async { //funzione per il login con google

    FirebaseAuth auth = FirebaseAuth.instance; //crea un'istanza di Firebase Auth

    final db = FirebaseDatabase(databaseURL: "https://roncadin-application-default-rtdb.europe-west1.firebasedatabase.app/")
    .reference().child("Users"); //crea un'istanza di Firebase Realtime Database

    User? user; //crea un'istanza di User
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);
          user = userCredential.user;
          final uid = user?.uid;
          String ID = uid.toString();
          print("L'ID è $ID");

          //aggiunge l'utente al database (se è un utente nuovo)
          db.child(ID).set(
          {
            'email': googleSignInAccount.email,
            'nickname' : googleSignInAccount.displayName,
          }
          );

        } on FirebaseAuthException catch (e) { //se sono presenti degli errori, viene mostrato al centro della schermata un messaggio di errore
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
  }

  static Future<void> signOut({required BuildContext context}) async { //funzione per la disconnessione dell'account google, usata in ProfileScreen (vedi riga 74 di profile_screen.dart)
    try {
      if (!kIsWeb) { 
        await GoogleSignIn().signOut(); //viene chiamato il metodo signOut() di GoogleSignIn() per disconnettere l'utente
        }
    } catch (e) { 
      print("Cannot logout (Google)");
      }
  }
}