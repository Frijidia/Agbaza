  import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  void _onSubmit(BuildContext context) {
    context.go('/professional/verify-code');
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
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    // Centered Logo
                    Center(
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Image.asset('assets/icons/logo.png', height: 54),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Récuperation du mot de passe',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Un code de recupération vous sera envoyé sur votre adresse mail abc@gmail.com',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF1E1E1E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () => _onBack(context),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: const BorderSide(
                                  color: Color(0xFF00553E),
                                ),
                              ),
                              child: Text(
                                'Retour',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF00553E),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _onSubmit(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00553E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Confirmer',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Right side - Image
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
