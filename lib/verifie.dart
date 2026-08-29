import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const verifie());
}

class verifie extends StatefulWidget {
  const verifie({super.key});

  @override
  State<verifie> createState() => _verifieState();
}

class _verifieState extends State<verifie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrôle Attestation',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        flexibleSpace: Image.asset(
          'images/logo.png',
          fit: BoxFit.fitWidth, // occupe toute la largeur
          width: double.infinity,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ⚠️ Bloc d’avertissement officiel
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ), // espace autour pour voir l’ombre
                decoration: BoxDecoration(
                  color: Colors.white,

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      spreadRadius: 0,
                      offset: Offset(0, 5), // ombre vers le bas
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD), // fond jaune clair
                        border: Border.all(
                          color: const Color.fromARGB(
                            255,
                            245,
                            225,
                            113,
                          ), // bordure jaune plus forte
                          width: 1, // épaisseur de la bordure
                        ),
                        borderRadius: BorderRadius.circular(
                          6,
                        ), // angles légèrement arrondis
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // aligné à gauche
                        children: [
                          Text(
                            'ATTENTION, TRÈS IMPORTANT :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Il est impératif de bien vérifier que l’URL sur laquelle mène le QR Code est bien',
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'https://controle.france-education-international.fr/',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Veuillez porter une attention vigilante à ce qu’il n’y ait pas une lettre de moins ou de plus '
                            '(par exemple : 2 "l" ou un "e" à la fin de "international").',
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    // fill informations
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ), // ✅ marges à gauche/droite
                            child: const Center(
                              child: Text(
                                "Consultation et vérification des résultats du TCF",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD), // fond jaune clair
                        border: Border.all(
                          color: const Color.fromARGB(
                            255,
                            245,
                            225,
                            113,
                          ), // bordure jaune
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            height:
                                1.4, // contrôle l’espacement entre les lignes (~5px)
                          ),
                          children: [
                            TextSpan(text: 'Résultats pour le '), // normal
                            TextSpan(
                              text:
                                  '« TCF - Test de connaissance du français »',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' du '), // normal
                            TextSpan(
                              text: '14/09/2025',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' pour le candidat '), // normal

                            TextSpan(text: '\n'), // saut de ligne
                            TextSpan(text: 'n°'), // normal
                            TextSpan(
                              text: '2732449.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            TextSpan(text: '\nNom : '), // normal
                            TextSpan(
                              text: 'ghlis',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            TextSpan(text: '\nPrénom : '), // normal
                            TextSpan(
                              text: 'lotfi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // image
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black26, // couleur de la bordure
                          width: 1, // épaisseur de la bordure
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // angles arrondis
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ), // marge autour du container
                      padding: const EdgeInsets.all(3), // espace interne
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          6,
                        ), // arrondi de l’image
                        child: InkWell(
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.scale,
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // 👉 Ligne avec "Photo" à gauche et X à droite
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // espace entre les deux
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            "Photo",
                                            style: TextStyle(
                                              fontSize: 16,

                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                            ).pop(); // ferme le dialogue
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  // 👉 Divider sous le header
                                  const Divider(
                                    color: Colors.black26,
                                    thickness: 1,
                                    height: 1,
                                  ),

                                  const SizedBox(height: 10),

                                  // 👉 Image avec bordure
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Image.asset(
                                      "images/foto.jpeg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),

                                  // 👉 Divider sous l’image
                                  const Divider(
                                    color: Colors.black26,
                                    thickness: 1,
                                    height: 1,
                                  ),

                                  // 👉 Bouton Fermer
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },

                                        label: const Text(
                                          "Fermer",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).show();
                          },
                          child: Image.asset(
                            "images/foto.jpeg", // chemin de ton image
                            fit: BoxFit.contain, // ajuste l’image
                            width:
                                double.infinity, // prend toute la largeur dispo
                          ),
                        ),
                      ),
                    ),
                    //tableau
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Table(
                        border: TableBorder.all(
                          color: Colors.black26,
                          width: 1,
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(2), // Épreuve
                          1: FlexColumnWidth(1.3), // Score/Note
                          2: FlexColumnWidth(1), // Niveau CECRL
                        },
                        children: const [
                          // Ligne d’en-tête
                          TableRow(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 242, 243),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 40,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Épreuve',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 40,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Score/Note',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Niveau CECRL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Résultat global
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Résultat global'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('520'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('C1'),
                              ),
                            ],
                          ),

                          // Compréhension orale
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Compréhension orale'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('487'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('B2'),
                              ),
                            ],
                          ),

                          // Maîtrise des structures de la langue
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Maîtrise des structures de la langue',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('518'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('C1'),
                              ),
                            ],
                          ),

                          // Compréhension écrite
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Compréhension écrite'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('555'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('C1'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 📌 Footer officiel
              Container(
                width: double.infinity, // ✅ prend toute la largeur
                color: Colors.grey[300],
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Accessibilité : non conforme',
                      style: TextStyle(color: Color(0xFF00AEEF), fontSize: 10),
                    ),
                    Text(
                      '© France Éducation international',
                      style: TextStyle(color: Colors.black54, fontSize: 10),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
