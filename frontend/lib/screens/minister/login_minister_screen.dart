import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:frontend/utils/constants.dart';
//import 'package:frontend/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginMinisterScreen extends StatefulWidget {
  const LoginMinisterScreen({super.key});

  @override
  State<LoginMinisterScreen> createState() => _LoginMinisterScreenState();
}

class _LoginMinisterScreenState extends State<LoginMinisterScreen> {
  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _identifiantController.addListener(_updateFormValidity);
    _passwordController.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    final isValid = _identifiantController.text.isNotEmpty && 
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
    _identifiantController.removeListener(_updateFormValidity);
    _passwordController.removeListener(_updateFormValidity);
    _identifiantController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args == 'logout_success') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Déconnecté avec succès', style: GoogleFonts.poppins()),
              backgroundColor: const Color(0xFF00553E),
            ),
          );
        });
      }
    }

  void _onNext(BuildContext context) {
    final String identifiant = _identifiantController.text.trim();
    final String password = _passwordController.text.trim();
    
    if (identifiant.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print('Tentative de connexion avec: $identifiant');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Connexion en cours...'),
        backgroundColor: Color(0xFF00553E),
      ),
    );
    

    context.go('/minister/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A9B97),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 900;
          if (isDesktop) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 36),
                      child: _RoleSelectionContent(
                        identifiantController: _identifiantController,
                        passwordController: _passwordController,
                        obscurePassword: _obscurePassword,
                        onNext: () => _onNext(context),
                        togglePasswordVisibility: _togglePasswordVisibility,
                        isFormValid: _isFormValid,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/medic_homme.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  margin: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _RoleSelectionContent(
                          identifiantController: _identifiantController,
                          passwordController: _passwordController,
                          obscurePassword: _obscurePassword,
                          onNext: () => _onNext(context),
                          togglePasswordVisibility: _togglePasswordVisibility,
                          isFormValid: _isFormValid,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/medic_homme.png',
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class _RoleSelectionContent extends StatelessWidget {
  final TextEditingController identifiantController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onNext;
  final VoidCallback togglePasswordVisibility;
  final bool isFormValid;

  const _RoleSelectionContent({
    required this.identifiantController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onNext,
    required this.togglePasswordVisibility,
    required this.isFormValid,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF00553E);
    return DefaultTextStyle(
      style: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo
          Center(
            child: Column(
              children: [
                Image.asset('assets/icons/logo.png', height: 54),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Text(
              "Le meilleur moyen d'être proche de votre santé",
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Connexion',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: identifiantController,
            decoration: InputDecoration(
              labelText: 'Identifiant',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: green, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: green, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: green, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: green, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: green, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: green, width: 2),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: green,
                ),
                onPressed: togglePasswordVisibility,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isFormValid ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text('Connectez-vous'),
            ),
          ),
        ],
      ),
    );
  }
}