import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../route.dart';
import 'userclass.dart';

class DatabaseService {

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance.collection('users');
  String role;
  UserData user;

  BuildContext context;

  void signIn(BuildContext context, _email, _password){
    this.context = context;

    try{
      auth.signInWithEmailAndPassword(email: _email, password: _password)
      .then((_) => {
          FirebaseFirestore
          .instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .get()
          .then((snapshot) => {
              if(snapshot.exists){
                if(snapshot.data()['role'] == 'verifier')
                  Navigator.of(context).pushNamed(AppRoutes.authVerifier)
                else
                  Navigator.of(context).pushNamed(AppRoutes.authPassenger),
              }else print('snapshot does not exist'),
            }),
      });
    }on Exception catch(e){
      print(e);
    } 
  } 

  void signOut(){
    auth.signOut();
    Navigator.of(context).pop();
  }

  DateTime convertDate(Timestamp time){
    Timestamp _dateofVaccination = time;
    return _dateofVaccination.toDate();
  }

  UserData getUserInformation(String uid){
    try{
      UserData userData;
      db
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) => {
        if(documentSnapshot.exists){
          userData = new 
          UserData(
            auth.currentUser.uid, 
            documentSnapshot.data()['F_name'], 
            documentSnapshot.data()['L_name'], 
            documentSnapshot.data()['Address'], 
            documentSnapshot.data()['M_Brand'], 
            documentSnapshot.data()['Brand_name'], 
            documentSnapshot.data()['Brand_number'], 
            convertDate(documentSnapshot.data()['Date_of_Vaccination']), 
            documentSnapshot.data()['Placed_vacined'], 
            documentSnapshot.data()['Physician_name'], 
            convertDate(documentSnapshot.data()['RT_PCR_Date']), 
            documentSnapshot.data()['License_no'],
          ),
          role = documentSnapshot.data()['role'],
        }
      });
      return userData;
    } on Exception{
      return null;
    }
  }
}