import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcf/verifie.dart';

class verification extends StatefulWidget {
  const verification({super.key});

  @override
  State<verification> createState() => _verificationState();
}

class _verificationState extends State<verification> {
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _attestationController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  DateTime? _selectedDate;
  String? _attestationError;
  String? _dateError;
  @override
  void dispose() {
    _attestationController.dispose();
    _dateController.dispose();
    _captchaController.dispose();
    super.dispose();
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 50,
                              ), // ✅ marges à gauche/droite
                              child: const Center(
                                child: Text(
                                  "Consultation et vérification des résultats d'une attestation du TCF",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: const Border(
                                  top: BorderSide(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                  left: BorderSide(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                  right: BorderSide(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                                  // pas de bordure en bas
                                ), // ✅ petite bordure grise
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "Renseignez les informations présentes sur l’attestation",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black26,
                                ), // ✅ petite bordure grise
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_attestationError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        _attestationError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  // Ligne Numéro d’attestation
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Numéro d’attestation",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          style: const TextStyle(
                                            color: Colors
                                                .black, // ✅ texte noir visible
                                          ),
                                          controller: _attestationController,

                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 12,
                                                ),

                                            hintStyle: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  if (_dateError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        _dateError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  // Ligne Date de la session
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Date de la session",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          controller: _dateController,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),

                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                  locale: const Locale(
                                                    "fr",
                                                    "FR",
                                                  ),
                                                );
                                            if (pickedDate != null) {
                                              _dateController.text = DateFormat(
                                                "d MMMM yyyy",
                                                "fr_FR",
                                              ).format(pickedDate);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  // Bloc d’information bleu clair
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F4FA),
                                      border: Border.all(
                                        color: const Color(0xFF007BBD),
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              // Cercle avec point d’exclamation
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Container(
                                                  width: 17,

                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    '?',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const WidgetSpan(
                                                child: SizedBox(width: 8),
                                              ),

                                              // Texte qui revient sous l’icône
                                              const TextSpan(
                                                text:
                                                    "Où trouver le numéro d’attestation et la date de session ?",
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Attention : pour le numéro d’attestation, vous devez saisir uniquement la partie après le dernier tiret (\"-\").",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        InkWell(
                                          onTap: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.noHeader,
                                              animType: AnimType.scale,
                                              body: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  // 👉 X en haut à droite
                                                  SizedBox(
                                                    width: double.infinity,

                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,

                                                      children: [
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

                                                  // 👉 Divider sous le X
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
                                                    ),
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 10,
                                                        ),
                                                    child: Image.asset(
                                                      "images/tcf.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),

                                                  // 👉 Divider sous l’image
                                                  const Divider(
                                                    color: Colors.black26,
                                                    thickness: 1,
                                                    height: 1,
                                                  ),

                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10,
                                                        ),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton.icon(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.grey,

                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4,
                                                                ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop(); // ferme le dialogue
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
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "• ",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "Cliquez ici pour voir où se trouve le numéro d’attestation et la date de session sur l’attestation dématérialisée.",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xFF007BBD),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Image.asset(
                                    "images/captcha.png", // mets le chemin de ton image
                                    width: 200, // largeur personnalisée
                                    fit: BoxFit.contain, // ajuste l’image
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Saisisez la somme des deux nombres en chiffres",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Ligne Captcha
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          controller: _captchaController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: "Somme en chiffres",
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Veuillez saisir la somme des deux nombres en chiffres !"; // ✅ message rouge sous le champ
                                            }
                                            if (value.trim() != "9") {
                                              return "Le code de sécurité est incorrect";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),

                                  // Bouton rechercher
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF007BBD,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          // ✅ Vérifie chaque champ et affiche l’erreur au-dessus de la Row
                                          _attestationError =
                                              _attestationController.text
                                                  .trim()
                                                  .isEmpty
                                              ? "Le champ \"Numéro d’attestation\" est obligatoire !"
                                              : null;

                                          _dateError =
                                              _dateController.text
                                                  .trim()
                                                  .isEmpty
                                              ? "Le champ \"Date de session\" est obligatoire !"
                                              : null;
                                        });

                                        // ✅ Déclenche la validation du champ captcha via son validator
                                        if (_formKey.currentState!.validate() &&
                                            _attestationError == null &&
                                            _dateError == null) {
                                          final attestation =
                                              _attestationController.text
                                                  .trim();
                                          final sessionDate = _dateController
                                              .text
                                              .trim();
                                          final captcha = _captchaController
                                              .text
                                              .trim();

                                          if (attestation.toLowerCase() == "7c425e082d1c" &&
        sessionDate == "14/09/2025" &&
        captcha == "9") {
      // ✅ Affiche le loader
      showLoadingDialog(context);

      try {
        await Future.delayed(const Duration(seconds: 1));

        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const verifie()),
        );
      } finally {
        // ✅ Ferme le loader
        Navigator.of(context).pop();
      }
    }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      label: const Text(
                                        "Rechercher l’attestation",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                        style: TextStyle(
                          color: Color(0xFF00AEEF),
                          fontSize: 10,
                        ),
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
      ),
    );
  }
}
