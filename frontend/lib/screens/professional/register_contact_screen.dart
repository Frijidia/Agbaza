import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterContactScreen extends StatefulWidget {
  const RegisterContactScreen({super.key});

  @override
  State<RegisterContactScreen> createState() => _RegisterContactScreenState();
}

class _RegisterContactScreenState extends State<RegisterContactScreen> {
  final TextEditingController _paysController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();

  void _onNext(BuildContext context) {
    context.go('/professional/register-password');
  }

  void _onBack(BuildContext context) {
    context.go('/professional/register');
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
                    Text('Informations personnelles', style: GoogleFonts.poppins(fontSize: 16)),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Pays', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _paysController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Ville', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _villeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('NIP', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _nipController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                          color: i == 1 ? const Color(0xFF00553E) : Colors.grey[300],
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
