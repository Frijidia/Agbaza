import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterProfessionalScreen extends StatefulWidget {
  const RegisterProfessionalScreen({super.key});

  @override
  State<RegisterProfessionalScreen> createState() => _RegisterProfessionalScreenState();
}

class _RegisterProfessionalScreenState extends State<RegisterProfessionalScreen> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  String? _selectedGenre;
  String? _selectedProfil;

  final List<String> _genres = ['Masculin', 'Féminin', 'Autre'];
  final List<String> _profils = [
    'Médecin généraliste',
    'Spécialiste',
    'Infirmier',
    'Pharmacien',
    'Autre',
  ];

  void _onNext(BuildContext context) {
    context.go('/professional/register-contact');
  }

  void _onBack(BuildContext context) {
    context.go('/professional/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => _onBack(context),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, color: Color(0xFF00553E)),
                            Text('Retour', style: GoogleFonts.poppins(color: Color(0xFF00553E))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Image.asset('assets/icons/logo.png', height: 50),
                          //Text('agbaza', style: GoogleFonts.poppins(color: Color(0xFF00553E), fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Création de compte', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Identifiants et sécurité', style: GoogleFonts.poppins(fontSize: 16)),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nom', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        hintText: 'Espoir',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Prénom', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        hintText: 'Kouadio',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Genre', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _selectedGenre,
                      items: _genres.map((genre) => DropdownMenuItem(
                        value: genre,
                        child: Text(genre, style: GoogleFonts.poppins()),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGenre = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        hintText: 'Sélectionner le genre',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Profil', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _selectedProfil,
                      items: _profils.map((profil) => DropdownMenuItem(
                        value: profil,
                        child: Text(profil, style: GoogleFonts.poppins()),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProfil = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        hintText: 'Sélectionner le profil',
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _onNext(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00553E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Suivant', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) => Container(
                        width: 40,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: i == 2 ? const Color(0xFF00553E) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/medic_homme.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
