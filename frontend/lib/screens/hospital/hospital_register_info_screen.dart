import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HospitalRegisterInfoScreen extends StatefulWidget {
  const HospitalRegisterInfoScreen({super.key});

  @override
  State<HospitalRegisterInfoScreen> createState() => _HospitalRegisterInfoScreenState();
}

class _HospitalRegisterInfoScreenState extends State<HospitalRegisterInfoScreen> {
  final _establishmentNameController = TextEditingController();
  final _identificationController = TextEditingController();
  String _selectedStructureType = 'Laboratoire';
  String _selectedCity = 'Cotonou';

  bool get _canProceed => 
      _establishmentNameController.text.isNotEmpty && 
      _identificationController.text.isNotEmpty;

  void _nextStep() {
    if (_canProceed) {
      context.go('/hospital/register-additional-info');
    }
  }

  @override
  void dispose() {
    _establishmentNameController.dispose();
    _identificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Partie gauche avec le formulaire
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 120,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                      child: Column(
                        children: [
                          Image.asset('assets/icons/logo.png', height: 50),
                          //Text('agbaza', style: GoogleFonts.poppins(color: Color(0xFF00553E), fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  // Logo
                  Row(
                    children: [
                      //Container(
                      //  width: 40,
                      //  height: 40,
                      //  decoration: BoxDecoration(
                      //    color: Color(0xFF00553E),
                      //    borderRadius: BorderRadius.circular(8),
                      //  ),
                        //child: Icon(
                        //  Icons.local_hospital,
                        //  color: Colors.white,
                        //  size: 24,
                        //),
                      //),
                     // SizedBox(width: 12),
                     // Center(
                     // child: Column(
                     //   children: [
                     //     Image.asset('assets/icons/logo.png', height: 50),
                     //     //Text('agbaza', style: GoogleFonts.poppins(color: Color(0xFF00553E), fontWeight: FontWeight.bold, fontSize: 18)),
                     //   ],
                     // ),
                   //),
                    //Text(
                      //'agbaza',
                      //style: GoogleFonts.poppins(
                      //  fontSize: 20,
                      //  fontWeight: FontWeight.bold,
                      //  color: Color(0xFF00553E),
                      //),
                    //),
                    ],
                  ),
                  SizedBox(height: 40),
                  
                  // Bouton retour
                  GestureDetector(
                    onTap: () => context.go('/hospital/register-login'),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Color(0xFF00553E), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Retour',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF00553E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Titre
                  Text(
                    'Créer le compte de l\'établissement',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Informations',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Nom de l'établissement
                  Text(
                    'Nom de l\'établissement',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _establishmentNameController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'SAINT JEAN',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF00553E)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(height: 24),

                  // N° d'identification / Agrément
                  Text(
                    'N° d\'identification / Agrément',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _identificationController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: '970726068E626',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF00553E)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(height: 24),

                  // Type de structure
                  Text(
                    'Type de structure',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStructureType,
                        isExpanded: true,
                        items: [
                          'Laboratoire',
                          'Clinique',
                          'Hôpital',
                          'Centre de santé',
                          'Pharmacie',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(color: Colors.grey[700]),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStructureType = newValue!;
                          });
                        },
                        style: GoogleFonts.poppins(color: Colors.grey[700]),
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Commune / Ville
                  Text(
                    'Commune / Ville',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCity,
                        isExpanded: true,
                        items: [
                          'Cotonou',
                          'Porto-Novo',
                          'Parakou',
                          'Abomey-Calavi',
                          'Djougou',
                          'Bohicon',
                          'Kandi',
                          'Ouidah',
                          'Lokossa',
                          'Natitingou',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(color: Colors.grey[700]),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCity = newValue!;
                          });
                        },
                        style: GoogleFonts.poppins(color: Colors.grey[700]),
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 40),

                  // Bouton suivant et indicateur de progression
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _canProceed ? _nextStep : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _canProceed 
                                ? Color(0xFF00553E) 
                                : Colors.grey[300],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Suivant',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      // Indicateur de progression (1/5)
                      Row(
                        children: [
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Colors.grey[300]),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Colors.grey[300]),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Colors.grey[300]),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Colors.grey[300]),
                        ],
                      ),
                    ],
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Partie droite avec l'image
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/hopital_img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}