import 'dart:html';
import 'dart:ui';

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
  List<Forfait> forfaits = [];
  // late Future<List<Forfait>> futursForfaits;
  //

  initState() {
    super.initState();
    // futursForfaits = _fetchForfaits();
    //
    Iterable list = json.decode('[{"_id":"6000ff360efa3fd999621bed","destination":"Jamaïque","villeDepart":"Montreal", "hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "https://picsum.photos/600/240", "da":"0000000"},{"_id":"6000ff370efa3fd999621c03","destination":"Alaska","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff380efa3fd999621c19","destination":"Japon","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff390efa3fd999621c2f","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3a0efa3fd999621c45","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #7","coordonnees":"...","nombreEtoiles":2,"nombreChambres":20,"caracteristiques":[]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":3000,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3c0efa3fd999621c5b","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #8","coordonnees":"...","nombreEtoiles":3,"nombreChambres":300,"caracteristiques":["Face à la plage","Miniclub","..."]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":30000,"rabais":100,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3e0efa3fd999621c71","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3f0efa3fd999621c87","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #7","coordonnees":"...","nombreEtoiles":2,"nombreChambres":20,"caracteristiques":[]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":3000,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff400efa3fd999621c9d","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #8","coordonnees":"...","nombreEtoiles":3,"nombreChambres":300,"caracteristiques":["Face à la plage","Miniclub","..."]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":30000,"rabais":100,"vedette":false,"image" : "", "da":"0000000"}]');
    forfaits = list.map((model) => Forfait.fromJson(model)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      itemCount: forfaits.length,
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
                                              Text(forfaits[index].destination,
                                                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Hotel : '),
                                              Text(forfaits[index].hotel.nom,
                                                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.7),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Prix : '),
                                              Text(forfaits[index].prix.toString(),
                                                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3),),
                                              Text(' \$')
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Ville de depart : '),
                                              Text(forfaits[index].villeDepart),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Duree : '),
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
                                              Text(forfaits[index].hotel.nombreEtoiles.toString()),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amberAccent,
                                                size: 24.0,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Coordonnees : '),
                                              Text(forfaits[index].hotel.coordonnees),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Date de depart : '),
                                              Text(forfaits[index].dateDepart.toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Date de retour : '),
                                              Text(forfaits[index].dateRetour.toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Nombre de chambres : '),
                                              Text(forfaits[index].hotel.nombreChambres.toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Caracteristiques : '),
                                              Text(forfaits[index].hotel.caracteristiques.toString()),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),

                          );
                      }))
            ],
          ),
        )
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
