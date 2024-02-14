import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  Future<User?> signInWithGoogle( ) async {

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      final GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

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
          return user ;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // handle the error here
          }
          else if (e.code == 'invalid-credential') {
            // handle the error here
          }
        } catch (e) {
          // handle the error here
        }
      }
      return user;
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }


  }
}