import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    // print();
    List members = [moi.uid, widget.autrePersonne.uid];
    members.sort();
    String string = members.join("_");
    print(string);
    FirestoreHelper()
        .cloudMessages
        // .where("senderId", whereIn: [moi.uid, widget.autrePersonne.uid])
        // .where("receiverId", whereIn: [moi.uid, widget.autrePersonne.uid])
        .where("members", isEqualTo: string)
        //ajouter condition pour le receiver
        // .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          messages = event.docs.map((e) => Message(e)).toList();
          messages.sort((a, b) => a.date.compareTo(b.date));
        });
      }
    });
    // print(messages);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(widget.autrePersonne.avatar ?? defaultImage),
            ),
            SizedBox(width: 12),
            Text(widget.autrePersonne.fullName),
          ],
        ),
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
                        DateTime dateTime = message.date.toDate();
                        DateTime now = DateTime.now();
                        DateTime today = DateTime(now.year, now.month, now.day);
                        bool isToday = dateTime.isAfter(today);
                        return Container(
                          //A améliorer
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: (message.senderId == moi.uid)
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Container(
                                  color: (message.senderId == moi.uid)
                                      ? Color.fromARGB(255, 166, 138, 222)
                                      : Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                    message.content,
                                    textAlign: (message.senderId == moi.uid)
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: (message.senderId == moi.uid)
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: (isToday)
                                    ? Text(
                                        "${dateTime.hour}:${dateTime.minute}")
                                    : Text(
                                        "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}"),
                              ),
                            ],
                          ),
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
                          List members = [moi.uid, widget.autrePersonne.uid];
                          members.sort();
                          FirestoreHelper().cloudMessages.add({
                            'members': members.join("_"),
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
