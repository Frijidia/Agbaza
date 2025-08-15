import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/responsive_sidebar.dart';

class RecapPatientScreen extends StatelessWidget {
  final Map<String, String> patientData;

  const RecapPatientScreen({super.key, required this.patientData});

  void _savePatient(BuildContext context) {
    // Ici vous pouvez ajouter la logique pour sauvegarder le patient
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Patient ajouté avec succès', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF00553E),
      ),
    );
    
    // Retourner à la page de gestion des patients
    context.go('/professional/management');
  }

  // Classes pour la notification (copiées depuis dashboard_screen.dart)
  Widget _buildNotificationPopup() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Notifications', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.close, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            child: Center(
              child: Text('Aucune notification', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isDesktop = screenWidth > 900;
        final isTablet = screenWidth > 600 && screenWidth <= 900;
        final isMobile = screenWidth <= 600;

        return Scaffold(
          appBar: isMobile ? AppBar(
            title: Text('Récapitulatif', style: GoogleFonts.poppins()),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ) : null,
          drawer: isMobile ? ResponsiveSidebar.buildDrawer(context, 'management') : null,
          body: Row(
            children: [
              if (!isMobile) ResponsiveSidebar(currentPage: 'management'),
          // Main content
          Expanded(
            child: Container(
              color: const Color(0xFFF6F6F6),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
                  vertical: isMobile ? 16 : 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête
                    GestureDetector(
                      onTap: () => context.go('/professional/add-patient', extra: {
                        'patientData': patientData,
                        'step': 2, // Retourner à l'étape d'assurance
                      }),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Color(0xFF00553E)),
                          const SizedBox(width: 8),
                          Text(isMobile ? 'Retour' : 'Retour à l\'ajout', style: GoogleFonts.poppins(color: Color(0xFF00553E))),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                    
                    // Nom du patient et NIP
                    Row(
                      children: [
                        Text(
                          '${patientData['nom']?.toUpperCase() ?? ''} ${patientData['prenom'] ?? ''}',
                          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                patientData['nip'] ?? '',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('NIP copié dans le presse-papiers'),
                                      backgroundColor: const Color(0xFF00553E),
                                    ),
                                  );
                                },
                                child: Icon(Icons.copy, size: 16, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    // Contenu principal avec le même format que PatientDetailScreen
                    if (isMobile) ...[
                      // Version mobile - cartes empilées
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Informations personnelles', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 16),
                              // Informations personnelles en mobile
                              Text('Email', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['email'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Date de naissance', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['date'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Numéro', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['numero'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Profession', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['profession'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Adresse', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['adresse'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Informations médicales', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 16),
                              Text('Taille', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text('${patientData['taille'] ?? ''} cm', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Groupe sanguin', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['groupe_sanguin'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Poids', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text('${patientData['poids'] ?? ''} kg', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Electrophorèse', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['electrophorese'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              const SizedBox(height: 16),
                              Text('Allergies', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(patientData['allergies'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      // Version desktop - cartes côte à côte
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Informations personnelles
                          Expanded(
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Informations personnelles', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Email', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text(patientData['email'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Date de naissance', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text(patientData['date'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Numéro', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text(patientData['numero'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Profession', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text(patientData['profession'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Adresse', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                            const SizedBox(height: 4),
                                            Text(patientData['adresse'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Informations médicales
                          Expanded(
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Informations médicales', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Taille', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text('${patientData['taille'] ?? ''} cm', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Groupe sanguin', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text(patientData['groupe_sanguin'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Poids', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text('${patientData['poids'] ?? ''} kg', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Electrophorèse', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 4),
                                                  Text(patientData['electrophorese'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Allergies', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                            const SizedBox(height: 4),
                                            Text(patientData['allergies'] ?? '', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 24),
                    
                    // Deuxième rangée avec Vaccinations et Assurance
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 800) {
                          // Vue mobile/tablette - cartes empilées
                          return Column(
                            children: [
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                color: Colors.white,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Vaccinations', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 16),
                                      if ((patientData['vaccinations'] ?? '').isNotEmpty)
                                        Wrap(
                                          spacing: 12,
                                          runSpacing: 8,
                                          children: (patientData['vaccinations'] ?? '')
                                              .split(',')
                                              .map((vaccination) => vaccination.trim())
                                              .where((vaccination) => vaccination.isNotEmpty)
                                              .map((vaccination) => Chip(
                                                    label: Text(vaccination, style: GoogleFonts.poppins(fontSize: 12)),
                                                    backgroundColor: Colors.grey[100],
                                                  ))
                                              .toList(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                color: Colors.white,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                                                             Row(
                                         children: [
                                           Text('Assurance', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                           const SizedBox(width: 8),
                                           Text('Vérifications', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                                           const SizedBox(width: 4),
                                           const Icon(Icons.warning, color: Colors.orange, size: 16),
                                         ],
                                       ),
                                       const SizedBox(height: 16),
                                       Text('Couverture AMO', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                       const SizedBox(height: 12),
                                      if ((patientData['soins_inclus'] ?? '').isNotEmpty)
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 4,
                                          children: (patientData['soins_inclus'] ?? '')
                                              .split(',')
                                              .map((soin) => soin.trim())
                                              .where((soin) => soin.isNotEmpty)
                                              .map((soin) => Chip(
                                                    label: Text(
                                                      soin,
                                                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
                                                    ),
                                                    backgroundColor: Colors.grey[100],
                                                    side: BorderSide(color: Colors.grey[300]!, width: 0.5),
                                                  ))
                                              .toList(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Vue desktop - cartes côte à côte
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Vaccinations', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                        const SizedBox(height: 16),
                                        if ((patientData['vaccinations'] ?? '').isNotEmpty)
                                          Wrap(
                                            spacing: 12,
                                            runSpacing: 8,
                                            children: (patientData['vaccinations'] ?? '')
                                                .split(',')
                                                .map((vaccination) => vaccination.trim())
                                                .where((vaccination) => vaccination.isNotEmpty)
                                                .map((vaccination) => Chip(
                                                      label: Text(vaccination, style: GoogleFonts.poppins(fontSize: 12)),
                                                      backgroundColor: Colors.grey[100],
                                                    ))
                                                .toList(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                                                                 Row(
                                           children: [
                                             Text('Assurance', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                             const SizedBox(width: 8),
                                             Text('Vérifications', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                                             const SizedBox(width: 4),
                                             const Icon(Icons.warning, color: Colors.orange, size: 16),
                                           ],
                                         ),
                                         const SizedBox(height: 16),
                                         Text('Couverture AMO', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                         const SizedBox(height: 12),
                                        if ((patientData['soins_inclus'] ?? '').isNotEmpty)
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 4,
                                            children: (patientData['soins_inclus'] ?? '')
                                                .split(',')
                                                .map((soin) => soin.trim())
                                                .where((soin) => soin.isNotEmpty)
                                                .map((soin) => Chip(
                                                      label: Text(
                                                        soin,
                                                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
                                                      ),
                                                      backgroundColor: Colors.grey[100],
                                                      side: BorderSide(color: Colors.grey[300]!, width: 0.5),
                                                    ))
                                                .toList(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Barre de progression (4 étapes)
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00553E),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00553E),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00553E),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00553E),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Boutons en bas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () => context.go('/professional/add-patient', extra: {
                            'patientData': patientData,
                            'step': 2, // Retourner à l'étape d'assurance
                          }),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF00553E),
                            side: const BorderSide(color: Color(0xFF00553E)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.arrow_back, size: 18),
                              const SizedBox(width: 8),
                              Text('Précédent', style: GoogleFonts.poppins()),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _savePatient(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00553E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.save, size: 18),
                              const SizedBox(width: 8),
                              Text('Enregistrer', style: GoogleFonts.poppins()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
      },
    );
  }
} 