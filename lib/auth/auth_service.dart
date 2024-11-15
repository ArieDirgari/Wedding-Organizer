import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  

  Future<User?> signUp(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      User? user = userCredential.user;
      if (user != null) {
      await saveLoginStatus(user.uid, email); }
      return user;
    }
    catch(e){
      return null;
    }
  }

  Future<User?> login (String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
      await saveLoginStatus(user.uid, email);
      
    }
    return user;
    }
    catch(e){
      return null;
    }
  }

  Future<void> saveLoginStatus(String userId, String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userId', userId);
  await prefs.setString('email', email);
  print(userId);
  print(email);
}
}