import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ProductsManagementScreen extends StatefulWidget {
  const ProductsManagementScreen({super.key});

  @override
  State<ProductsManagementScreen> createState() => _ProductsManagementScreenState();
}

class _ProductsManagementScreenState extends State<ProductsManagementScreen> {
  String _selectedFilter = '30 jours';
  String _selectedPeriod = 'Derniers ajouts';
  final _searchController = TextEditingController();
  bool _showAddForm = false;
  
  // Controllers pour les inputs d'ajout
  final _nomController = TextEditingController();
  final _classeController = TextEditingController();
  final _quantiteController = TextEditingController();
  final _prixController = TextEditingController();
  final _dateController = TextEditingController();

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
    _nomController.dispose();
    _classeController.dispose();
    _quantiteController.dispose();
    _prixController.dispose();
    _dateController.dispose();
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
                        _buildMenuItem('Gestion des sangs', false),
                        _buildMenuItem('Gestion des produits', true),
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
                          'Gestion des produits',
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
                            setState(() {
                              _showAddForm = !_showAddForm;
                              if (!_showAddForm) {
                                // Vider les champs quand on ferme le formulaire
                                _nomController.clear();
                                _classeController.clear();
                                _quantiteController.clear();
                                _prixController.clear();
                                _dateController.clear();
                              }
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
                          icon: Icon(_showAddForm ? Icons.close : Icons.add, size: 18),
                          label: Text(
                            _showAddForm ? 'Annuler' : 'Ajouter un produit',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Tableau des produits
                  Expanded(
                    child: _buildProductsTable(),
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

  Widget _buildProductsTable() {
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
                SizedBox(width: 16),
                Expanded(flex: 2, child: _buildTableHeader('Classe')),
                SizedBox(width: 16),
                Expanded(flex: 1, child: _buildTableHeader('Quantité')),
                SizedBox(width: 16),
                Expanded(flex: 2, child: _buildTableHeader('Prix estimé')),
                SizedBox(width: 16),
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
                            SizedBox(width: 16),
                            Expanded(flex: 2, child: _buildTableCell(product['classe'])),
                            SizedBox(width: 16),
                            Expanded(flex: 1, child: _buildTableCell(product['quantite'])),
                            SizedBox(width: 16),
                            Expanded(flex: 2, child: _buildTableCell(product['prix'])),
                            SizedBox(width: 16),
                            Expanded(flex: 2, child: _buildTableCell(product['dateMaj'])),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // Ligne d'ajout avec inputs (seulement si _showAddForm est true)
                if (_showAddForm) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      color: Color(0xFFF8F9FA).withOpacity(0.5),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: _buildInputField('Nom du produit', _nomController)),
                        SizedBox(width: 16),
                        Expanded(flex: 2, child: _buildInputField('Classe', _classeController)),
                        SizedBox(width: 16),
                        Expanded(flex: 1, child: _buildInputField('Qté', _quantiteController)),
                        SizedBox(width: 16),
                        Expanded(flex: 2, child: _buildInputField('Prix', _prixController)),
                        SizedBox(width: 16),
                        Expanded(flex: 2, child: _buildInputField('Date', _dateController)),
                      ],
                    ),
                  ),
                  
                  // Bouton Enregistrer
                  Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _addProduct,
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
              ],
            ),
          ),
        ],
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

  Widget _buildInputField(String hint, TextEditingController controller) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
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

  void _addProduct() {
    // Vérifier que tous les champs sont remplis
    if (_nomController.text.isEmpty ||
        _classeController.text.isEmpty ||
        _quantiteController.text.isEmpty ||
        _prixController.text.isEmpty ||
        _dateController.text.isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Veuillez remplir tous les champs',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Ajouter le nouveau produit à la liste
    setState(() {
      _products.add({
        'nom': _nomController.text,
        'classe': _classeController.text,
        'quantite': _quantiteController.text,
        'prix': _prixController.text,
        'dateMaj': _dateController.text,
      });

      // Vider les champs
      _nomController.clear();
      _classeController.clear();
      _quantiteController.clear();
      _prixController.clear();
      _dateController.clear();

      // Masquer le formulaire
      _showAddForm = false;
    });

    // Afficher un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Produit ajouté avec succès !',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Color(0xFF00553E),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
