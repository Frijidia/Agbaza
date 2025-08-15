import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HospitalRegisterSecurityScreen extends StatefulWidget {
  const HospitalRegisterSecurityScreen({super.key});

  @override
  State<HospitalRegisterSecurityScreen> createState() => _HospitalRegisterSecurityScreenState();
}

class _HospitalRegisterSecurityScreenState extends State<HospitalRegisterSecurityScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get _canProceed => 
      _emailController.text.isNotEmpty && 
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _passwordController.text == _confirmPasswordController.text;

  void _nextStep() {
    if (_canProceed) {
      context.go('/hospital/register-documents');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      //  child: Icon(
                      //    Icons.local_hospital,
                      //    color: Colors.white,
                      //    size: 24,
                      //  ),
                      //),
                      //SizedBox(width: 12),
                      //Text(
                      //  'agbaza',
                      //  style: GoogleFonts.poppins(
                      //    fontSize: 20,
                      //    fontWeight: FontWeight.bold,
                      //    color: Color(0xFF00553E),
                      //  ),
                      //),
                    ],
                  ),
                  SizedBox(height: 40),
                  
                  // Bouton retour
                  GestureDetector(
                    onTap: () => context.go('/hospital/register-additional-info'),
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
                    'Identifiants et sécurité',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Email
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    onChanged: (_) => setState(() {}),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'abcd@gmail.com',
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

                  // Mot de passe
                  Text(
                    'Mot de passe',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        child: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[400],
                        ),
                      ),
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

                  // Confirmer mot de passe
                  Text(
                    'Confirmer mot de passe',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        child: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[400],
                        ),
                      ),
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
                      errorText: _confirmPasswordController.text.isNotEmpty && 
                                 _passwordController.text != _confirmPasswordController.text 
                                 ? 'Les mots de passe ne correspondent pas'
                                 : null,
                    ),
                    style: GoogleFonts.poppins(),
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
                      // Indicateur de progression (3/5)
                      Row(
                        children: [
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
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