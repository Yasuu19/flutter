import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/constante.dart';
import 'package:ipssi_bd23_2/controller/firestoreHelper.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';

class AllPerson extends StatefulWidget {
  const AllPerson({Key? key}) : super(key: key);

  @override
  State<AllPerson> createState() => _AllPersonState();
}

class _AllPersonState extends State<AllPerson>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<Color?> _heartColorAnimation;
  // late Animation<double> _heartSizeAnimation;

  // void animationStart() {
  //   _animationController.forward();
  // }

  // void animationEnd() {
  //   _animationController.reverse();
  // }

  @override
  void initState() {
    super.initState();

    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    // );
    // CurvedAnimation curvedAnimation =
    //     CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    // _heartColorAnimation = ColorTween(begin: Colors.grey, end: Colors.red)
    //     .animate(curvedAnimation);
    // _heartSizeAnimation =
    //     Tween<double>(begin: 24, end: 60).animate(curvedAnimation);
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  List<String> favoritedUserIds =
      []; // List to keep track of favorited user IDs
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().cloudUsers.snapshots(),
        builder: (context, snap) {
          List? documents = snap.data?.docs;
          if (documents == []) {
            return const Text("Aucune Donnée");
          } else {
            return ListView.builder(
                itemCount: documents!.length,
                itemBuilder: (context, index) {
                  Utilisateur lesAutres = Utilisateur(documents[index]);

                  return Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(lesAutres.avatar ?? defaultImage),
                      ),
                      title: Text(lesAutres.fullName),
                      subtitle: Text(
                        lesAutres.email,
                        textAlign: TextAlign.start,
                      ),
                      trailing: lesAutres.uid != moi.uid
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  // print(_heartSizeAnimation.value);
                                  if (moi.favoris!.contains(lesAutres.uid)) {
                                    // animationEnd();
                                    moi.favoris!.remove(lesAutres.uid);
                                  } else {
                                    // animationStart();
                                    moi.favoris!.add(lesAutres.uid);
                                  }
                                  FirestoreHelper().updateUser(
                                      moi.uid, {"FAVORIS": moi.favoris});
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                // color: _heartColorAnimation.value,
                                // size: _heartSizeAnimation.value,
                                color: moi.favoris!.contains(lesAutres.uid)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            )
                          : null,
                    ),
                  );
                });
          }
        });
  }
}
