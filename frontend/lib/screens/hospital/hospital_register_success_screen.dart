import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HospitalRegisterSuccessScreen extends StatefulWidget {
  const HospitalRegisterSuccessScreen({super.key});

  @override
  State<HospitalRegisterSuccessScreen> createState() => _HospitalRegisterSuccessScreenState();
}

class _HospitalRegisterSuccessScreenState extends State<HospitalRegisterSuccessScreen> {

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
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF00553E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.local_hospital,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'agbaza',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00553E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  
                  // Bouton retour
                  GestureDetector(
                    onTap: () => context.go('/hospital/register-security'),
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
                  SizedBox(height: 60),

                  // Titre principal
                  Text(
                    'Créer le compte de l\'établissement',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 60),

                  // Message de succès
                  Center(
                    child: Column(
                      children: [
                        // Icône de succès
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFF00553E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        SizedBox(height: 32),
                        
                        // Texte de confirmation
                        Text(
                          'Votre compte a été créé avec succès !',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        
                        // Sous-titre
                        Text(
                          'Vérifications',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 40),

                  // Bouton Se connecter
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => context.go('/hospital/register-login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00553E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Se connecter',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Indicateur de progression (5/5 - tous les segments verts)
                  Row(
                    children: [
                      Container(width: 48, height: 4, color: Color(0xFF00553E)),
                      SizedBox(width: 6),
                      Container(width: 48, height: 4, color: Color(0xFF00553E)),
                      SizedBox(width: 6),
                      Container(width: 48, height: 4, color: Color(0xFF00553E)),
                      SizedBox(width: 6),
                      Container(width: 48, height: 4, color: Color(0xFF00553E)),
                      SizedBox(width: 6),
                      Container(width: 48, height: 4, color: Color(0xFF00553E)),
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