import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipssi_bd23_2/controller/constante.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';
import '../controller/firestoreHelper.dart';

class Message {
  late String uid;
  // late List<String> members;
  late String members;
  late String senderId;
  late String receiverId;
  late String content;
  late Timestamp date;

  Future<Utilisateur> get receiver async {
    return await FirestoreHelper().getUser(receiverId);
  }

  Future<Utilisateur> get sender async {
    return await FirestoreHelper().getUser(senderId);
  }

  Message(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    members = map["members"];
    senderId = map["senderId"];
    receiverId = map["receiverId"];
    content = map["content"];
    date = map["date"];
  }
}
