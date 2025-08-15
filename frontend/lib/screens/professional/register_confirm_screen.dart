import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterConfirmScreen extends StatelessWidget {
  const RegisterConfirmScreen({super.key});

  void _onFinish(BuildContext context) {
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
                        onPressed: () => _onFinish(context),
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
                          Text('agbaza', style: GoogleFonts.poppins(color: Color(0xFF00553E), fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Création de compte', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Votre compte a été créé avec succès !', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),
                    Text(
                      "Un lien vous a été envoyé par mail. Veuillez utiliser ce lien pour effectuer votre première connexion.",
                      style: GoogleFonts.poppins(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) => Container(
                        width: 40,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00553E),
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
