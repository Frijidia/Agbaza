import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class BedsManagementScreen extends StatefulWidget {
  const BedsManagementScreen({super.key});

  @override
  State<BedsManagementScreen> createState() => _BedsManagementScreenState();
}

class _BedsManagementScreenState extends State<BedsManagementScreen> {
  final _searchController = TextEditingController();
  bool _isEditMode = false;
  
  // Controllers pour les inputs d'édition
  final _totalBedsController = TextEditingController(text: '120');
  final _availableBedsController = TextEditingController(text: '25');
  final _standardBedsController = TextEditingController(text: '10');
  final _pediatricBedsController = TextEditingController(text: '7');
  final _maternityBedsController = TextEditingController(text: '8');
  
  // État des checkboxes pour la modal d'ajout de catégories
  Map<String, bool> _categoryCheckboxes = {
    'Lits standard': false,
    'Lits pédiatrie': false,
    'Lits maternité': false,
    'Lits de chirurgie': false,
    'Lits d\'urgence': false,
    'Lits de soins intensifs': false,
    'Lits de psychiatrie': false,
  };

  @override
  void dispose() {
    _searchController.dispose();
    _totalBedsController.dispose();
    _availableBedsController.dispose();
    _standardBedsController.dispose();
    _pediatricBedsController.dispose();
    _maternityBedsController.dispose();
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
                        _buildMenuItem('Gestion des lits', true),
                        _buildMenuItem('Gestion des sangs', false),
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
                          'Gestion des lits',
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
                                    hintText: 'Rechercher une place',
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
                  
                  // Contenu de la gestion des lits
                  Expanded(
                    child: _buildBedsContent(),
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
          if (title == 'Gestion des sangs') {
            context.go('/hospital/blood-management');
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

  Widget _buildBedsContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          // Section "Disponibilité des lits"
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
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
                    setState(() {
                      _isEditMode = !_isEditMode;
                    });
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
                      Text(
                        _isEditMode ? 'Enregistrer' : 'Modifier',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        _isEditMode ? Icons.save : Icons.edit,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Statistiques principales ou inputs d'édition
          if (_isEditMode) ...[
            _buildEditModeContent(),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Lits totale',
                    _totalBedsController.text,
                    'lits',
                    '36 %',
                    Colors.green,
                    true,
                  ),
                ),
                SizedBox(width: 32),
                Expanded(
                  child: _buildStatCard(
                    'Lits disponible',
                    _availableBedsController.text,
                    'cas',
                    '26 %',
                    Colors.red,
                    false,
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: 24),
          
          // Texte informatif en bas
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Mettre à jour le maps permettra de visualiser en temps réel la disponibilité des lits dans les hôpitaux, des poches de sang par groupe sanguin et localité, des médicaments et matériels dans les hôpitaux et pharmacies publiques.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditModeContent() {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colonne gauche - Informations médicales
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
                _buildEditInputRow('Totale', _totalBedsController),
                SizedBox(height: 12),
                _buildEditInputRow('Disponible', _availableBedsController),
              ],
            ),
          ),
          
          SizedBox(width: 48),
          
          // Colonne droite - Catégories de lits
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
                    Expanded(
                      child: _buildEditCategoryInput('Lits standard', _standardBedsController),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildEditCategoryInput('Lits pédiatrie', _pediatricBedsController),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildEditCategoryInput('Lits maternité', _maternityBedsController),
                    ),
                  ],
                ),
                SizedBox(height: 16),
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
    );
  }

  Widget _buildEditInputRow(String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
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
          SizedBox(
            width: 60,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditCategoryInput(String category, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
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
          SizedBox(height: 8),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            keyboardType: TextInputType.number,
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
                    Text(_standardBedsController.text, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lits pédiatrie', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    Text(_pediatricBedsController.text, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lits maternité', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    Text(_maternityBedsController.text, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
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
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
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
          SizedBox(height: 8),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 18,
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
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                      'Ajouter catégorie de lits',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // Checkboxes pour les catégories
                    ..._categoryCheckboxes.keys.map((category) {
                      return _buildCheckboxItem(
                        category, 
                        _categoryCheckboxes[category]!,
                        (value) {
                          setModalState(() {
                            _categoryCheckboxes[category] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                    
                    SizedBox(height: 24),
                    
                    // Boutons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Reset les checkboxes
                            setState(() {
                              _categoryCheckboxes.updateAll((key, value) => false);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Annuler',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            _addSelectedCategories();
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
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCheckboxItem(String label, bool isChecked, [ValueChanged<bool?>? onChanged]) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            activeColor: Color(0xFF00553E),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged?.call(!isChecked),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addSelectedCategories() {
    List<String> selectedCategories = _categoryCheckboxes.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    
    if (selectedCategories.isNotEmpty) {
      // Afficher un message de confirmation ou traiter les catégories sélectionnées
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Catégories ajoutées: ${selectedCategories.join(", ")}',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Color(0xFF00553E),
          duration: Duration(seconds: 2),
        ),
      );
      
      // Reset les checkboxes après ajout
      setState(() {
        _categoryCheckboxes.updateAll((key, value) => false);
      });
    }
  }
}
