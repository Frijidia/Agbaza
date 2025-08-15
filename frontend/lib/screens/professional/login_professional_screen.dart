import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginProfessionalScreen extends StatefulWidget {
  const LoginProfessionalScreen({super.key});

  @override
  State<LoginProfessionalScreen> createState() => _LoginProfessionalScreenState();
}

class _LoginProfessionalScreenState extends State<LoginProfessionalScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateFormValidity);
    _passwordController.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    final isValid = _emailController.text.isNotEmpty && 
                   _passwordController.text.isNotEmpty;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateFormValidity);
    _passwordController.removeListener(_updateFormValidity);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    // For demo purposes, accepting any input
    context.go('/professional/dashboard');
  }

  void _onForgotPassword(BuildContext context) {
    context.go('/professional/forgot-password');
  }

  void _onRegister(BuildContext context) {
    context.go('/professional/register');
  }

  void _onTermsOfService() {
    // TODO: Naviguer vers la page des conditions d'utilisation
    print('Conditions d\'utilisation');
  }

  void _onPrivacyPolicy() {
    // TODO: Naviguer vers la page de politique de confidentialité
    print('Politique de confidentialité');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          children: [
            // Left side - Form
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // logo
                    Center(
                        child: Column(
                          children: [
                            Image.asset('assets/icons/logo.png', height: 54),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    const SizedBox(height: 30),
                    // Title
                    Text(
                      'Le meilleur moyen et le plus simple de vous tenir informé sur vos clients .',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Email Field
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'abc@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF00553E), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password Field
                    Text(
                      'Mot de passe',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF00553E), width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _onForgotPassword(context),
                        child: Text(
                          'Mots de passe oublié ?',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF00553E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Terms and conditions text
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        children: [
                          const TextSpan(text: 'En cliquant sur le bouton, vous acceptez nos '),
                          TextSpan(
                            text: 'conditions d\'utilisation',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF00553E),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTermsOfService,
                          ),
                          const TextSpan(text: ' et notre '),
                          TextSpan(
                            text: 'politique de confidentialité',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF00553E),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onPrivacyPolicy,
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _onLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00553E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Connectez-vous',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Register Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vous n\'avez pas encore de compte ? ',
                            style: GoogleFonts.poppins(),
                          ),
                          TextButton(
                            onPressed: () => _onRegister(context),
                            child: Text(
                              'Enregistrez-vous',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF00553E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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