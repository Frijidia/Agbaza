import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:frontend/utils/constants.dart';
//import 'package:frontend/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;

  void _onRoleSelected(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  void _onNext(BuildContext context) {
    if (selectedRole == null) return;
    if (selectedRole == 'Ministère') {
      context.go('/minister/login');
    } else if (selectedRole == 'Patient') {
      // TODO: Naviguer vers la page de connexion patient
    } else if (selectedRole == 'Professionnel') {
      context.go('/professional/login');
    } else if (selectedRole == 'Hôpital') {
      context.go('/hospital/register-info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A9B97),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 900;
          if (isDesktop) {
            // Mode desktop : le conteneur blanc prend toute la largeur et hauteur
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  // Partie gauche (logo, texte, boutons)
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 36),
                      child: _RoleSelectionContent(
                        selectedRole: selectedRole,
                        onRoleSelected: _onRoleSelected,
                        onNext: () => _onNext(context),
                      ),
                    ),
                  ),
                  // Partie droite (image)
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/medic_femme.png',
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
            // Mode mobile/tablette : carte centrée avec image en bas
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
                          selectedRole: selectedRole,
                          onRoleSelected: _onRoleSelected,
                          onNext: () => _onNext(context),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/medic_femme.png',
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
  final String? selectedRole;
  final void Function(String) onRoleSelected;
  final VoidCallback onNext;
  const _RoleSelectionContent({
    required this.selectedRole,
    required this.onRoleSelected,
    required this.onNext,
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
            'Connectez vous en tant que :',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 18),
          _RoleButton(
            label: 'Patient',
            isSelected: selectedRole == 'Patient',
            onTap: () => onRoleSelected('Patient'),
          ),
          const SizedBox(height: 14),
          _RoleButton(
            label: 'Professionnel',
            isSelected: selectedRole == 'Professionnel',
            onTap: () => onRoleSelected('Professionnel'),
          ),
          const SizedBox(height: 14),
          _RoleButton(
            label: 'Ministère',
            isSelected: selectedRole == 'Ministère',
            onTap: () => onRoleSelected('Ministère'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedRole == null ? null : onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedRole == null ? green.withOpacity(0.15) : green,
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
              child: Text(
                'Suivant',
                style: TextStyle(
                  color: selectedRole == null ? green.withOpacity(0.5) : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  const _RoleButton({
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF00553E);
    const greenSelected = Color(0x8000553E); // #00553E80
    return SizedBox(
      width: double.infinity,
      child: isSelected
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: greenSelected,
                foregroundColor: green,
                side: const BorderSide(color: green, width: 2),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onTap,
              child: Text(label, style: const TextStyle(color: green)),
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: green,
                side: const BorderSide(color: green, width: 1.5),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onTap,
              child: Text(label),
            ),
    );
  }
} 