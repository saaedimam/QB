import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUserRole() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return 'guest';

  final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  return doc.exists ? doc.data()?['role'] ?? 'user' : 'user';
}
