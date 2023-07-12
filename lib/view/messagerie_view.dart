import 'package:ipssi_bd23_2/model/utilisateur.dart';
import 'package:ipssi_bd23_2/model/message.dart';
import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/view/background_view.dart';

import '../controller/constante.dart';
import '../controller/firestoreHelper.dart';

class MessagerieView extends StatefulWidget {
  Utilisateur autrePersonne;
  MessagerieView({Key? key, required this.autrePersonne}) : super(key: key);

  @override
  State<MessagerieView> createState() => _MessagerieViewState();
}

class _MessagerieViewState extends State<MessagerieView> {
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    FirestoreHelper()
        .cloudMessages
        .where("senderId", isEqualTo: moi.uid)
        //ajouter condition pour le receiver
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        messages = event.docs.map((e) => Message(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.autrePersonne.fullName),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundView(),
          bodyPage(),
        ],
      ),
    );
  }

  Widget bodyPage() {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            //message qui va être affiché
            Flexible(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        Message message = messages[index];
                        return Container(
                          //A améliorer
                          child: Text(message.content),
                        );
                      })),
            ),
            const Divider(
              height: 1.5,
            ),
            //message qu'on  tape
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Entrer votre message"),
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (messageController.text != "") {
                          String message = messageController.text;
                          FirestoreHelper().cloudMessages.add({
                            'content': message,
                            'date': DateTime.now(),
                            'senderId': moi.uid,
                            'receiverId': widget.autrePersonne.uid
                          });
                          setState(() {
                            messageController.text = "";
                          });
                        }
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
