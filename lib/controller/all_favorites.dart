import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/constante.dart';
import 'package:ipssi_bd23_2/controller/firestoreHelper.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';

class AllFavorites extends StatefulWidget {
  const AllFavorites({Key? key}) : super(key: key);

  @override
  State<AllFavorites> createState() => _AllFavoritesState();
}

class _AllFavoritesState extends State<AllFavorites> {
  List<Utilisateur> users = [];
  List mesFavoris = [];

  late AnimationController _animationController;
  late Animation<Color?> _heartColorAnimation;
  late Animation<double> _heartSizeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < moi.favoris!.length; i++) {
      FirestoreHelper().getUser(moi.favoris![i]).then((value) {
        setState(() {
          mesFavoris.add(value);
        });
      });
    }
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mesFavoris.length,
        itemBuilder: (context, index) {
          Utilisateur user = mesFavoris[index];
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(user.avatar ?? defaultImage),
                          ),
                          SizedBox(height: 16),
                          Text(user.fullName ?? "Nom",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(user.email),
                          SizedBox(height: 8),
                          Text(user.telephone ?? "Téléphone"),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Fermer"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Card(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.avatar ?? defaultImage),
                ),
                title: Text(user.fullName ?? "Nom"),
                subtitle: Text(user.email, textAlign: TextAlign.start),
              ),
            ),
          );
          // );
          // });
        });
  }
}
