import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HospitalRegisterLoginScreen extends StatefulWidget {
  const HospitalRegisterLoginScreen({super.key});

  @override
  State<HospitalRegisterLoginScreen> createState() => _HospitalRegisterLoginScreenState();
}

class _HospitalRegisterLoginScreenState extends State<HospitalRegisterLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  bool get _canProceed => 
      _emailController.text.isNotEmpty && 
      _passwordController.text.isNotEmpty && 
      _acceptTerms;

  void _nextStep() {
    if (_canProceed) {
      context.go('/hospital/dashboard');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  // Logo
                  Center(
                      child: Column(
                        children: [
                          Image.asset('assets/icons/logo.png', height: 50),
                          //Text('agbaza', style: GoogleFonts.poppins(color: Color(0xFF00553E), fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                    //  Container(
                    //    width: 40,
                    //    height: 40,
                    //    decoration: BoxDecoration(
                    //      color: Color(0xFF00553E),
                    //      borderRadius: BorderRadius.circular(8),
                    //    ),
                    //    child: Icon(
                    //      Icons.local_hospital,
                    //      color: Colors.white,
                    //      size: 24,
                    //    ),
                    //  ),
                    //  SizedBox(width: 12),
                    //  Text(
                    //    'agbaza',
                    //    style: GoogleFonts.poppins(
                    //      fontSize: 20,
                    //      fontWeight: FontWeight.bold,
                    //      color: Color(0xFF00553E),
                    //    ),
                    //  ),
                    ],
                  ),
                  SizedBox(height: 60),

                  // Titre
                  Text(
                    'Mettez à jour vos informations sur le maps',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Champ Email
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

                  // Champ Mot de passe
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
                  SizedBox(height: 16),

                  // Lien mot de passe oublié
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Implémenter mot de passe oublié
                      },
                      child: Text(
                        'Mots de passe oublié ?',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF00553E),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Checkbox conditions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) => setState(() => _acceptTerms = value ?? false),
                        activeColor: Color(0xFF00553E),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            children: [
                              TextSpan(text: 'En cliquant sur le bouton, vous acceptez nos '),
                              TextSpan(
                                text: 'conditions d\'utilisation',
                                style: TextStyle(
                                  color: Color(0xFF00553E),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' et notre '),
                              TextSpan(
                                text: 'politique de confidentialité',
                                style: TextStyle(
                                  color: Color(0xFF00553E),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 40),

                  // Bouton Connectez-vous
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
                        'Connectez-vous',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Lien inscription
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        children: [
                          TextSpan(text: 'Vous n\'avez pas encore de compte ? '),
                          TextSpan(
                            text: 'Enregistrez-vous',
                            style: TextStyle(
                              color: Color(0xFF00553E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
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