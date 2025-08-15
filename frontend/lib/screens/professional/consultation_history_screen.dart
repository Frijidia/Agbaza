import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/responsive_sidebar.dart';

class ConsultationHistoryScreen extends StatefulWidget {
  final Map<String, String> patient;
  final Map<String, dynamic> consultation;
  
  const ConsultationHistoryScreen({
    super.key, 
    required this.patient,
    required this.consultation,
  });

  @override
  State<ConsultationHistoryScreen> createState() => _ConsultationHistoryScreenState();
}

class _ConsultationHistoryScreenState extends State<ConsultationHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedResultType = 'Maladie';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth <= 600;

        return Scaffold(
          appBar: isMobile ? AppBar(
            title: Text('Historique traitement', style: GoogleFonts.poppins()),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ) : null,
          drawer: isMobile ? ResponsiveSidebar.buildDrawer(context, 'management') : null,
          body: Row(
            children: [
              if (!isMobile) ResponsiveSidebar(currentPage: 'management'),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/medic_femme.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header avec informations patient
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 32,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            // Bouton retour
                            GestureDetector(
                              onTap: () => context.go('/professional/patient-detail', extra: widget.patient),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.arrow_back, color: Color(0xFF00553E), size: 20),
                                    SizedBox(width: 4),
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
                            ),
                            Spacer(),
                            // Informations patient
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Color(0xFF00553E), size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    widget.consultation['doctor'] ?? 'Dr GAHITO Nukonklu',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF00553E),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Titre principal
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Historique traitement',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.consultation['doctor'] ?? 'Espoir AGOLI-AGBO',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      // Contenu principal avec onglets
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // Barre d'onglets
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                ),
                                child: TabBar(
                                  controller: _tabController,
                                  indicatorColor: Color(0xFF00553E),
                                  labelColor: Color(0xFF00553E),
                                  unselectedLabelColor: Colors.grey[600],
                                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                  unselectedLabelStyle: GoogleFonts.poppins(),
                                  tabs: [
                                    Tab(text: 'Observations'),
                                    Tab(text: 'Analyses'),
                                    Tab(text: 'Résultats'),
                                    Tab(text: 'Ordonnances'),
                                  ],
                                ),
                              ),
                              // Contenu des onglets
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    _buildObservationsTab(),
                                    _buildAnalysesTab(),
                                    _buildResultsTab(),
                                    _buildPrescriptionsTab(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildObservationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFF00553E), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Observations médicales',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00553E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Analyses effectuées',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00553E),
                ),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  // Logique pour ajouter un fichier
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00553E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.add, size: 18),
                label: Text('Ajouter un fichier', style: GoogleFonts.poppins()),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Résultats de l\'analyse',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00553E),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedResultType,
                    isDense: true,
                    items: ['Maladie', 'Grippe', 'Paludisme', 'Fièvre typhoïde', 'Autre']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedResultType = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Résultats pour $_selectedResultType',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00553E),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5F0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF00553E).withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'MEDICAMENTS',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00553E),
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'POSOLOGIE',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00553E),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'médicaments',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'forte...',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF00553E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}