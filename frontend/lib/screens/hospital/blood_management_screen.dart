import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class BloodManagementScreen extends StatefulWidget {
  const BloodManagementScreen({super.key});

  @override
  State<BloodManagementScreen> createState() => _BloodManagementScreenState();
}

class _BloodManagementScreenState extends State<BloodManagementScreen> {
  final _searchController = TextEditingController();
  bool _isEditMode = false;
  
  // Controllers pour les données du tableau
  final Map<String, Map<String, TextEditingController>> _bloodControllers = {
    'A+': {
      'quantite': TextEditingController(text: '14'),
      'dateCollecte': TextEditingController(text: '15/08/2025'),
      'dateExpiration': TextEditingController(text: '15/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'A-': {
      'quantite': TextEditingController(text: '17'),
      'dateCollecte': TextEditingController(text: '12/08/2025'),
      'dateExpiration': TextEditingController(text: '12/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'B+': {
      'quantite': TextEditingController(text: '15'),
      'dateCollecte': TextEditingController(text: '10/08/2025'),
      'dateExpiration': TextEditingController(text: '10/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'B-': {
      'quantite': TextEditingController(text: '18'),
      'dateCollecte': TextEditingController(text: '08/08/2025'),
      'dateExpiration': TextEditingController(text: '08/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'AB+': {
      'quantite': TextEditingController(text: '12'),
      'dateCollecte': TextEditingController(text: '05/08/2025'),
      'dateExpiration': TextEditingController(text: '05/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'AB-': {
      'quantite': TextEditingController(text: '20'),
      'dateCollecte': TextEditingController(text: '02/08/2025'),
      'dateExpiration': TextEditingController(text: '02/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'O+': {
      'quantite': TextEditingController(text: '19'),
      'dateCollecte': TextEditingController(text: '01/08/2025'),
      'dateExpiration': TextEditingController(text: '01/11/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
    'O-': {
      'quantite': TextEditingController(text: '20'),
      'dateCollecte': TextEditingController(text: '30/07/2025'),
      'dateExpiration': TextEditingController(text: '30/10/2025'),
      'donneur': TextEditingController(text: 'ANONYME'),
    },
  };

  @override
  void dispose() {
    _searchController.dispose();
    // Dispose de tous les controllers
    for (var bloodType in _bloodControllers.values) {
      for (var controller in bloodType.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar gauche
          Container(
            width: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.6),
                ],
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/hopital_img.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.multiply,
                ),
              ),
            ),
            child: Column(
              children: [
                // Header avec nom de l'hôpital
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'HOPITALE ST JEAN',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                
                // Menu items
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildMenuItem('Gestion des lits', false),
                        _buildMenuItem('Gestion des sangs', true),
                        _buildMenuItem('Gestion des produits', false),
                        _buildMenuItem('Carte', false),
                        Spacer(),
                        // Bouton déconnexion
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.orange,
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => context.go('/'),
                                child: Text(
                                  'Déconnexion',
                                  style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
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
              ],
            ),
          ),
          
          // Contenu principal
          Expanded(
            child: Container(
              color: Color(0xFFF8F9FA),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header avec titre et recherche
                  Container(
                    padding: EdgeInsets.all(32),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gestion des sangs',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            // Barre de recherche
                            Expanded(
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Rechercher un patient en saisissant nom nom ou son NIP',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey[500],
                                      size: 20,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            // Bouton recherche
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Color(0xFF00553E),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Contenu de la gestion des sangs
                  Expanded(
                    child: _buildBloodContent(),
                  ),
                  
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, bool isActive) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (title == 'Gestion des lits') {
            context.go('/hospital/beds-management');
          } else if (title == 'Gestion des produits') {
            context.go('/hospital/products-management');
          } else if (title == 'Carte') {
            context.go('/hospital/map');
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBloodContent() {
    // Données des groupes sanguins avec quantités (depuis les controllers)
    final Map<String, int> bloodQuantities = {};
    for (String bloodType in _bloodControllers.keys) {
      bloodQuantities[bloodType] = int.tryParse(_bloodControllers[bloodType]!['quantite']!.text) ?? 0;
    }

    // Données du tableau depuis les controllers
    final List<Map<String, dynamic>> bloodTableData = _bloodControllers.keys.map((bloodType) {
      return {
        'groupe': bloodType,
        'quantite': _bloodControllers[bloodType]!['quantite']!.text,
        'statut': 'DISPONIBLE',
        'dateCollecte': _bloodControllers[bloodType]!['dateCollecte']!.text,
        'dateExpiration': _bloodControllers[bloodType]!['dateExpiration']!.text,
        'donneur': _bloodControllers[bloodType]!['donneur']!.text,
      };
    }).toList();

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              // Graphique en barres
              Container(
                height: 280,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isEditMode = !_isEditMode;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00553E),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          icon: Icon(
                            _isEditMode ? Icons.save : Icons.edit,
                            size: 16,
                          ),
                          label: Text(
                            _isEditMode ? 'Enregistrer' : 'Mise à jour des stocks',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: _buildBloodChart(bloodQuantities),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Tableau détaillé
              Container(
                height: 400, // Hauteur fixe pour éviter l'overflow
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header du tableau
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: _buildTableHeader('Groupe sanguin')),
                          SizedBox(width: 16),
                          Expanded(flex: 1, child: _buildTableHeader('Quantité')),
                          SizedBox(width: 16),
                          Expanded(flex: 2, child: _buildTableHeader('Statut')),
                          SizedBox(width: 16),
                          Expanded(flex: 2, child: _buildTableHeader('Date de collecte')),
                          SizedBox(width: 16),
                          Expanded(flex: 2, child: _buildTableHeader('Date d\'expiration')),
                          SizedBox(width: 16),
                          Expanded(flex: 2, child: _buildTableHeader('Donneur')),
                        ],
                      ),
                    ),
                    
                    // Lignes du tableau
                    Expanded(
                      child: ListView.builder(
                        itemCount: bloodTableData.length,
                        itemBuilder: (context, index) {
                          final blood = bloodTableData[index];
                          return GestureDetector(
                            onTap: () {
                              _showBloodDetailsModal(blood['groupe']);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Expanded(flex: 2, child: _buildBloodTypeCell(blood['groupe'])),
                                  SizedBox(width: 16),
                                  Expanded(flex: 1, child: _buildEditableCell(
                                    _bloodControllers[blood['groupe']]!['quantite']!,
                                    blood['quantite'],
                                    isNumeric: true,
                                  )),
                                  SizedBox(width: 16),
                                  Expanded(flex: 2, child: _buildBloodStatusCell(blood['statut'])),
                                  SizedBox(width: 16),
                                  Expanded(flex: 2, child: _buildEditableCell(
                                    _bloodControllers[blood['groupe']]!['dateCollecte']!,
                                    blood['dateCollecte'],
                                  )),
                                  SizedBox(width: 16),
                                  Expanded(flex: 2, child: _buildEditableCell(
                                    _bloodControllers[blood['groupe']]!['dateExpiration']!,
                                    blood['dateExpiration'],
                                  )),
                                  SizedBox(width: 16),
                                  Expanded(flex: 2, child: _buildEditableCell(
                                    _bloodControllers[blood['groupe']]!['donneur']!,
                                    blood['donneur'],
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              // Texte d'information en bas
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Mettre à jour le maps permettra de visualiser en temps réel la disponibilité des lits dans les hôpitaux, des poches de sang par groupe sanguin et localité, des médicaments et matériels dans les hôpitaux et pharmacies publiques.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              SizedBox(height: 32), // Espace final
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodChart(Map<String, int> bloodQuantities) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Labels de l'axe Y
          Container(
            width: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('20', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                Text('15', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                Text('10', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                Text('5', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                Text('0', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          
          SizedBox(width: 10),
          
          // Barres du graphique
          Expanded(
            child: Container(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bloodQuantities.entries.map((entry) {
                  final bloodType = entry.key;
                  final quantity = entry.value;
                  final barHeight = (quantity / 20) * 150; // Hauteur proportionnelle
                  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 24,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: Color(0xFF00553E),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        bloodType,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildTableCell(String content) {
    return Text(
      content,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildEditableCell(TextEditingController controller, String displayValue, {bool isNumeric = false}) {
    if (_isEditMode) {
      return Container(
        height: 36,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[800],
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFF00553E)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          onChanged: (value) {
            if (isNumeric) {
              // Mettre à jour le graphique en temps réel si c'est une quantité
              setState(() {});
            }
          },
        ),
      );
    } else {
      return Text(
        displayValue,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[800],
        ),
      );
    }
  }

  Widget _buildBloodTypeCell(String bloodType) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getBloodTypeColor(bloodType).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getBloodTypeColor(bloodType),
            width: 1,
          ),
        ),
        child: Text(
          bloodType,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _getBloodTypeColor(bloodType),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBloodStatusCell(String status) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Color(0xFFE8F5E8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          status,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E7D32),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color _getBloodTypeColor(String bloodType) {
    switch (bloodType) {
      case 'A+':
      case 'A-':
        return Colors.red;
      case 'B+':
      case 'B-':
        return Colors.blue;
      case 'AB+':
      case 'AB-':
        return Colors.purple;
      case 'O+':
      case 'O-':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showBloodDetailsModal(String bloodType) {
    // Données détaillées pour chaque sac de sang
    final List<Map<String, String>> detailedData = [
      {'sac': '01', 'rhesus': 'Rh+', 'volume': '450 ml', 'dateCollecte': '03/09/2024', 'datePeremption': '03/09/2024'},
      {'sac': '02', 'rhesus': 'Rh+', 'volume': '450 ml', 'dateCollecte': '03/09/2024', 'datePeremption': '03/09/2024'},
      {'sac': '03', 'rhesus': 'Rh+', 'volume': '450 ml', 'dateCollecte': '03/09/2024', 'datePeremption': '03/09/2024'},
      {'sac': '04', 'rhesus': 'Rh+', 'volume': '450 ml', 'dateCollecte': '03/09/2024', 'datePeremption': '03/09/2024'},
      {'sac': '05', 'rhesus': 'Rh+', 'volume': '450 ml', 'dateCollecte': '03/09/2024', 'datePeremption': '03/09/2024'},
      {'sac': '06', 'rhesus': 'Rh+', 'volume': '450 ml', 'dateCollecte': '03/09/2024', 'datePeremption': '03/09/2024'},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                // Header de la modal
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Groupe sanguin',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Quantité',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                
                // Informations du groupe sanguin
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      _buildBloodTypeCell(bloodType),
                      SizedBox(width: 24),
                      Text(
                        _bloodControllers[bloodType]!['quantite']!.text,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Informations',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Tableau détaillé
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        // Header du tableau
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: _buildModalTableHeader('Sac')),
                              Expanded(flex: 2, child: _buildModalTableHeader('Rhésus')),
                              Expanded(flex: 2, child: _buildModalTableHeader('Volume')),
                              Expanded(flex: 3, child: _buildModalTableHeader('Date de collecte')),
                              Expanded(flex: 3, child: _buildModalTableHeader('Date de péremption')),
                            ],
                          ),
                        ),
                        
                        // Lignes du tableau
                        Expanded(
                          child: ListView.builder(
                            itemCount: detailedData.length,
                            itemBuilder: (context, index) {
                              final item = detailedData[index];
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[200]!,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(flex: 1, child: _buildModalTableCell(item['sac']!)),
                                    Expanded(flex: 2, child: _buildModalTableCell(item['rhesus']!)),
                                    Expanded(flex: 2, child: _buildModalTableCell(item['volume']!)),
                                    Expanded(flex: 3, child: _buildModalTableCell(item['dateCollecte']!)),
                                    Expanded(flex: 3, child: _buildModalTableCell(item['datePeremption']!)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bouton en bas
                Container(
                  padding: EdgeInsets.all(24),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Mise à jour des stocks pour ce groupe
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00553E),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(Icons.edit, size: 16),
                      label: Text(
                        'Mise à jour des stocks',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalTableHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildModalTableCell(String content) {
    return Text(
      content,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[800],
      ),
    );
  }
}
