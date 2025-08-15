import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HospitalDashboardScreen extends StatefulWidget {
  const HospitalDashboardScreen({super.key});

  @override
  State<HospitalDashboardScreen> createState() => _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState extends State<HospitalDashboardScreen> {
  String _selectedSection = 'Gestion des produits';
  String _selectedFilter = '30 jours';
  String _selectedPeriod = 'Derniers ajouts';
  final _searchController = TextEditingController();

  // Données simulées pour les produits
  final List<Map<String, dynamic>> _products = [
    {
      'nom': 'Paracétamol',
      'classe': 'Analgésique',
      'quantite': '120',
      'prix': '100 FCFA',
      'dateMaj': '27/08/2025',
    },
    {
      'nom': 'Paracétamol',
      'classe': 'Analgésique',
      'quantite': '120',
      'prix': '100 FCFA',
      'dateMaj': '27/08/2025',
    },
    {
      'nom': 'Paracétamol',
      'classe': 'Analgésique',
      'quantite': '120',
      'prix': '100 FCFA',
      'dateMaj': '27/08/2025',
    },
    {
      'nom': 'Paracétamol',
      'classe': 'Analgésique',
      'quantite': '120',
      'prix': '100 FCFA',
      'dateMaj': '27/08/2025',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Redirection automatique vers la gestion des produits
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/hospital/products-management');
    });
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
                        _buildMenuItem('Gestion des lits', _selectedSection == 'Gestion des lits'),
                        _buildMenuItem('Gestion des sangs', _selectedSection == 'Gestion des sangs'),
                        _buildMenuItem('Gestion des produits', _selectedSection == 'Gestion des produits'),
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
                          _selectedSection,
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
                  
                  // Filtres et bouton ajouter
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Row(
                      children: [
                        // Filtres
                        _buildDropdownFilter(_selectedFilter, ['30 jours', '7 jours', '1 mois', '3 mois'], (value) {
                          setState(() => _selectedFilter = value!);
                        }),
                        SizedBox(width: 16),
                        _buildDropdownFilter(_selectedPeriod, ['Derniers ajouts', 'Plus anciens', 'A-Z', 'Z-A'], (value) {
                          setState(() => _selectedPeriod = value!);
                        }),
                        
                        Spacer(),
                        
                        // Bouton ajouter un produit
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Naviguer vers l'ajout de produit
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
                          icon: Icon(Icons.add, size: 18),
                          label: Text(
                            'Ajouter un produit',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Contenu dynamique selon la section
                  Expanded(
                    child: _buildSectionContent(),
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
          } else if (title == 'Gestion des sangs') {
            context.go('/hospital/blood-management');
          } else if (title == 'Gestion des produits') {
            context.go('/hospital/products-management');
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

  Widget _buildDropdownFilter(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: GoogleFonts.poppins(fontSize: 14),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 18),
        ),
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

  Widget _buildSectionContent() {
    switch (_selectedSection) {
      case 'Gestion des lits':
        return _buildBedsManagement();
      case 'Gestion des sangs':
        return _buildBloodManagement();
      case 'Gestion des produits':
      default:
        return _buildProductsManagement();
    }
  }

  Widget _buildProductsManagement() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
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
                Expanded(flex: 2, child: _buildTableHeader('Nom')),
                Expanded(flex: 2, child: _buildTableHeader('Classe')),
                Expanded(flex: 1, child: _buildTableHeader('Quantité')),
                Expanded(flex: 2, child: _buildTableHeader('Prix estimé')),
                Expanded(flex: 2, child: _buildTableHeader('Date MAJ')),
              ],
            ),
          ),
          
          // Lignes du tableau
          Expanded(
            child: Column(
              children: [
                // Produits existants
                Expanded(
                  child: ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                            Expanded(flex: 2, child: _buildTableCell(product['nom'])),
                            Expanded(flex: 2, child: _buildTableCell(product['classe'])),
                            Expanded(flex: 1, child: _buildTableCell(product['quantite'])),
                            Expanded(flex: 2, child: _buildTableCell(product['prix'])),
                            Expanded(flex: 2, child: _buildTableCell(product['dateMaj'])),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // Ligne d'ajout avec inputs
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      Expanded(flex: 2, child: _buildInputField('Nom du produit')),
                      SizedBox(width: 12),
                      Expanded(flex: 2, child: _buildInputField('Classe')),
                      SizedBox(width: 12),
                      Expanded(flex: 1, child: _buildInputField('Qté')),
                      SizedBox(width: 12),
                      Expanded(flex: 2, child: _buildInputField('Prix')),
                      SizedBox(width: 12),
                      Expanded(flex: 2, child: _buildInputField('Date')),
                    ],
                  ),
                ),
                
                // Bouton Enregistrer
                Container(
                  padding: EdgeInsets.all(24),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Ajouter le produit
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00553E),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Enregistrer',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedsManagement() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          // Statistiques principales
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Lits totale',
                  '120',
                  'lits',
                  '36 %',
                  Colors.green,
                  true,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _buildStatCard(
                  'Lits disponible',
                  '25',
                  'cas',
                  '26 %',
                  Colors.red,
                  false,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Détails des catégories
          Expanded(
            child: Container(
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
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Disponibilité des lits',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        _buildDropdownFilter('30 jours', ['30 jours', '7 jours', '1 mois'], (value) {}),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Modifier les lits
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00553E),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Modifier', style: GoogleFonts.poppins(fontSize: 12)),
                              SizedBox(width: 4),
                              Icon(Icons.edit, size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informations médicales',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildBedInfoRow('Totale', '120'),
                              SizedBox(height: 12),
                              _buildBedInfoRow('Disponible', '25'),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: 32),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informations médicales',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(child: _buildBedCategoryCard('Lits standard', '10')),
                                  SizedBox(width: 16),
                                  Expanded(child: _buildBedCategoryCard('Lits pédiatrie', '7')),
                                  SizedBox(width: 16),
                                  Expanded(child: _buildBedCategoryCard('Lits maternité', '8')),
                                ],
                              ),
                              SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showAddCategoryModal();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF00553E),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 0,
                                ),
                                icon: Icon(Icons.add, size: 16),
                                label: Text(
                                  'Ajouter catégorie',
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Spacer(),
                    
                    Text(
                      'Mettre à jour le maps permettra de visualiser en temps réel la disponibilité des lits dans les hôpitaux, des poches de sang par groupe sanguin et localité, des médicaments et matériels dans les hôpitaux et pharmacies publiques.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodManagement() {
    // Données des groupes sanguins avec quantités
    final Map<String, int> bloodQuantities = {
      'A+': 14,
      'A-': 17,
      'B+': 15,
      'B-': 18,
      'AB+': 12,
      'AB-': 20,
      'O+': 19,
      'O-': 20,
    };

    final List<Map<String, dynamic>> bloodTableData = [
      {'groupe': 'A+', 'quantite': '14', 'statut': 'DISPONIBLE', 'dateCollecte': '15/08/2025', 'dateExpiration': '15/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'A-', 'quantite': '17', 'statut': 'DISPONIBLE', 'dateCollecte': '12/08/2025', 'dateExpiration': '12/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'B+', 'quantite': '15', 'statut': 'DISPONIBLE', 'dateCollecte': '10/08/2025', 'dateExpiration': '10/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'B-', 'quantite': '18', 'statut': 'DISPONIBLE', 'dateCollecte': '08/08/2025', 'dateExpiration': '08/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'AB+', 'quantite': '12', 'statut': 'DISPONIBLE', 'dateCollecte': '05/08/2025', 'dateExpiration': '05/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'AB-', 'quantite': '20', 'statut': 'DISPONIBLE', 'dateCollecte': '02/08/2025', 'dateExpiration': '02/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'O+', 'quantite': '19', 'statut': 'DISPONIBLE', 'dateCollecte': '01/08/2025', 'dateExpiration': '01/11/2025', 'donneur': 'ANONYME'},
      {'groupe': 'O-', 'quantite': '20', 'statut': 'DISPONIBLE', 'dateCollecte': '30/07/2025', 'dateExpiration': '30/10/2025', 'donneur': 'ANONYME'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          // Graphique en barres
          Container(
            height: 300,
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
                        // TODO: Mise à jour des stocks
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
                      icon: Icon(Icons.edit, size: 16),
                      label: Text(
                        'Mise à jour des stocks',
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
          Expanded(
            child: Container(
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
                        Expanded(flex: 1, child: _buildTableHeader('Groupe sanguin')),
                        Expanded(flex: 1, child: _buildTableHeader('Quantité')),
                        Expanded(flex: 2, child: _buildTableHeader('Statut')),
                        Expanded(flex: 2, child: _buildTableHeader('Date de collecte')),
                        Expanded(flex: 2, child: _buildTableHeader('Date d\'expiration')),
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
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                              Expanded(flex: 1, child: _buildBloodTypeCell(blood['groupe'])),
                              Expanded(flex: 1, child: _buildTableCell(blood['quantite'])),
                              Expanded(flex: 2, child: _buildBloodStatusCell(blood['statut'])),
                              Expanded(flex: 2, child: _buildTableCell(blood['dateCollecte'])),
                              Expanded(flex: 2, child: _buildTableCell(blood['dateExpiration'])),
                              Expanded(flex: 2, child: _buildTableCell(blood['donneur'])),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Bouton Enregistrer les modifications
                  Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Enregistrer les modifications
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
                      icon: Icon(Icons.save, size: 16),
                      label: Text(
                        'Enregistrer les modifications',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Texte d'information en bas
          Text(
            'Mettre à jour le maps permettra de visualiser en temps réel la disponibilité des lits dans les hôpitaux, des poches de sang par groupe sanguin et localité, des médicaments et matériels dans les hôpitaux et pharmacies publiques.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[500],
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        style: GoogleFonts.poppins(fontSize: 12),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, String percentage, Color color, bool isUp) {
    return Container(
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
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Spacer(),
              Icon(
                isUp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: color,
                size: 20,
              ),
              Text(
                percentage,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  unit,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          if (title == 'Lits disponible') ...[
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lits standard', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    Text('10', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lits pédiatrie', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    Text('7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lits maternité', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    Text('8', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBedInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedCategoryCard(String category, String count) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(
            category,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 400,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lits standard',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                
                // Checkboxes pour les catégories
                _buildCheckboxItem('Lits standard', false),
                _buildCheckboxItem('Lits pédiatrie', false),
                _buildCheckboxItem('Lits maternité', false),
                _buildCheckboxItem('Lits de chirurgie', false),
                _buildCheckboxItem('4. Lits d\'urgence', false),
                _buildCheckboxItem('Lits de soins intensifs', false),
                _buildCheckboxItem('Lits de psychiatrie', false),
                
                SizedBox(height: 24),
                
                // Bouton Ajouter
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
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
                    child: Text(
                      'Ajouter',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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

  Widget _buildCheckboxItem(String label, bool isChecked) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              // TODO: Gérer la sélection
            },
            activeColor: Color(0xFF00553E),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodStatCard(String title, String value, String unit, String percentage, Color color, bool isUp) {
    return Container(
      padding: EdgeInsets.all(20),
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
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Spacer(),
              Icon(
                isUp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: color,
                size: 20,
              ),
              Text(
                percentage,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  unit,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeCell(String bloodType) {
    return Container(
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
    );
  }

  Widget _buildStatusCell(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'disponible':
        statusColor = Colors.green;
        break;
      case 'stock faible':
        statusColor = Colors.orange;
        break;
      case 'critique':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: statusColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // TODO: Modifier
          },
          icon: Icon(Icons.edit, size: 18, color: Colors.blue),
          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        IconButton(
          onPressed: () {
            // TODO: Supprimer
          },
          icon: Icon(Icons.delete, size: 18, color: Colors.red),
          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }

  Widget _buildBloodTypeDropdown() {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            'Groupe',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // TODO: Gérer la sélection
          },
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 16),
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

  Widget _buildBloodChart(Map<String, int> bloodQuantities) {
    final maxValue = bloodQuantities.values.reduce((a, b) => a > b ? a : b);
    
    return Column(
      children: [
        // Axe Y avec valeurs
        Expanded(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: bloodQuantities.entries.map((entry) {
                    final bloodType = entry.key;
                    final quantity = entry.value;
                    final barHeight = (quantity / 20) * 180; // 180 est la hauteur max
                    
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBloodStatusCell(String status) {
    return Container(
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
    );
  }
}
