// main.dart
// Par Charles-Etienne Villemure
// Le 26 Fevrier 2021
import 'dart:html';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forfaits Voyages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccueilForfaitsVoyages(title: 'Forfaits Voyages Charles-Etienne Villemure'),
    );
  }
}

class AccueilForfaitsVoyages extends StatefulWidget {
  AccueilForfaitsVoyages({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AccueilForfaitsVoyagesState createState() => AccueilForfaitsVoyagesState();
}

class AccueilForfaitsVoyagesState extends State<AccueilForfaitsVoyages> {
   Future<List<Forfait>> futursForfaits;
//Importation des forfaits
  Future<List<Forfait>> _fetchForfaits() async {
    final response = await http.get(Uri.https('forfaits-voyages.herokuapp.com', '/api/forfaits/da/1996340', {}));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((forfait) => new Forfait.fromJson(forfait)).toList();
    } else {
      throw Exception('Erreur de chargement des forfaits');
    }
  }



  initState() {
    futursForfaits = _fetchForfaits();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forfait>>(
      future: futursForfaits,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(title: Text(widget.title),
                centerTitle: true,),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return
                                Container(
                                  color: Colors.blueGrey,
                                  width: double.infinity,
                                  height: 200,
                                  margin: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex:2,
                                        child: Wrap(
                                          children: [

                                            Image.network(
                                              'https://picsum.photos/600/240',
                                              fit: BoxFit.fill,
                                              height: 200,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(15.0,0,0,0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Destination : '),
                                                    Text(snapshot.data[index].destination ?? '',
                                                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Hôtel : '),
                                                    Text(snapshot.data[index].hotel.nom ?? '',
                                                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.7)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Prix : '),
                                                    Text(snapshot.data[index].prix.toString() ?? '',
                                                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3)),
                                                    Text(' \$')
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Ville de départ : '),
                                                    Text(snapshot.data[index].villeDepart ?? ''),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Durée : '),
                                                    Text('7 Jours',
                                                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.1),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(snapshot.data[index].hotel.nombreEtoiles.toString() ?? ''),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amberAccent,
                                                      size: 24.0,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Coordonnée : '),
                                                    Text(snapshot.data[index].hotel.coordonnees ?? ''),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Date de départ : '),
                                                    Text(snapshot.data[index].dateDepart.toString() ?? ''),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Date de retour : '),
                                                    Text(snapshot.data[index].dateRetour.toString() ?? ''),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Nombre de chambres : '),
                                                    Text(snapshot.data[index].hotel.nombreChambres.toString() ?? ''),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Caractéristiques : '),
                                                    Text(snapshot.data[index].hotel.caracteristiques.toString() ?? ''),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                              )
                                    ],
                                  ),

                                );
                            }))
                  ],
                ),
              )
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class Forfait {
  final String id;
  final String destination;
  final String villeDepart;
  final DateTime dateDepart;
  final DateTime dateRetour;
  final String image;
  final int prix;
  final int rabais;
  final bool vedette;
  final Hotel hotel;

  Forfait({this.id, this.destination, this.villeDepart, this.hotel, this.dateDepart, this.dateRetour, this.image, this.prix, this.rabais, this.vedette});

  factory Forfait.fromJson(Map<String, dynamic> json) {
    return Forfait(
      id: json['_id'],
      destination: json['destination'],
      villeDepart: json['villeDepart'],
      dateDepart: DateTime.parse("2021-01-01"),
      dateRetour: DateTime.parse("2021-01-01"),
      image: json['image'],
      prix: json['prix'],
      rabais: json['rabais'],
      vedette: json['vedette'],
      hotel:Hotel.fromJson(json['hotel']),

    );
  }

}

class Hotel {
  final String nom;
  final String coordonnees;
  final int nombreEtoiles;
  final int nombreChambres;
  final List<String> caracteristiques;

  Hotel({this.nom, this.coordonnees, this.nombreEtoiles, this.nombreChambres, this.caracteristiques});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        nom:json['nom'],
        coordonnees:json['coordonnees'],
        nombreEtoiles: json['nombreEtoiles'],
        nombreChambres: json['nombreChambres'],
        caracteristiques: new List<String>.from(json['caracteristiques'])
    );
  }
}
