import 'package:flutter/material.dart';
import 'package:tcf/verification.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const DemoSite());
}

class DemoSite extends StatefulWidget {
  const DemoSite({super.key});

  @override
  State<DemoSite> createState() => _DemoSiteState();
}

class _DemoSiteState extends State<DemoSite> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrôle Attestation',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      home: const DemoHomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'), // français
        Locale('en', 'US'), // anglais optionnel
      ],
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {

    void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // ❌ empêche de fermer en cliquant à côté
      barrierColor: Colors.black.withOpacity(0.2), // fond semi-transparent
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF007BBD), // bleu clair
          ),
        );
      },
    );
  }
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

      body: Column(
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

                // 🔵 Bouton bleu clair avec texte centré
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BBD),
                      padding: const EdgeInsets.symmetric(
                        vertical: 7, // espace haut/bas
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () async {
                      showLoadingDialog(context);

                      // ✅ Attendre que la navigation soit terminée
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const verification(),
                        ),
                      );

                      // ✅ Fermer le loader une fois revenu sur la page précédente
                      Navigator.of(context).pop();
                    },


                    child: const Text(
                      'Pour contrôler l’authenticité de l’attestation cliquez-ici',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 📌 Footer officiel
          Expanded(
            child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start, // contenu en haut
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // aligné en haut
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(
                              'https://controle.france-education-international.fr/Accessibilite',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: const Text(
                            'Accessibilité : non conforme',
                            style: TextStyle(
                              color: Color(0xFF00AEEF),
                              fontSize: 10,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      const Flexible(
                        child: Text(
                          '© France Éducation international',
                          style: TextStyle(color: Colors.black54, fontSize: 10),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
