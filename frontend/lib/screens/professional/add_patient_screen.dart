import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/responsive_sidebar.dart';

class AddPatientScreen extends StatefulWidget {
  final Map<String, String>? initialData;
  final int? initialStep;
  
  const AddPatientScreen({super.key, this.initialData, this.initialStep});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();
  
  // Contrôleurs pour les informations personnelles
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  
  // Contrôleurs pour les informations médicales
  final TextEditingController _tailleController = TextEditingController();
  final TextEditingController _poidsController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _vaccinationsController = TextEditingController();
  
  // Contrôleurs pour l'assurance
  final TextEditingController _typeCouvertureController = TextEditingController();
  final TextEditingController _soinsInclusController = TextEditingController();

  // Variables pour les dropdowns
  String? _selectedGroupeSanguin;
  String? _selectedElectrophorese;

  // Listes d'options pour les dropdowns
  final List<String> _groupesSanguins = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  final List<String> _electrophoreses = [
    'AA', 'AS', 'AC', 'SS' 'SC', 'CC'
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialiser l'étape et les données si fournies
    _currentStep = widget.initialStep ?? 0;
    
    if (widget.initialData != null) {
      final data = widget.initialData!;
      _nomController.text = data['nom'] ?? '';
      _prenomController.text = data['prenom'] ?? '';
      _dateController.text = data['date'] ?? '';
      _numeroController.text = data['numero'] ?? '';
      _emailController.text = data['email'] ?? '';
      _professionController.text = data['profession'] ?? '';
      _adresseController.text = data['adresse'] ?? '';
      _nipController.text = data['nip'] ?? '';
      _tailleController.text = data['taille'] ?? '';
      _poidsController.text = data['poids'] ?? '';
      _allergiesController.text = data['allergies'] ?? '';
      _vaccinationsController.text = data['vaccinations'] ?? '';
      _typeCouvertureController.text = data['type_couverture'] ?? '';
      _soinsInclusController.text = data['soins_inclus'] ?? '';
      
      // Initialiser les dropdowns
      _selectedGroupeSanguin = data['groupe_sanguin']?.isNotEmpty == true ? data['groupe_sanguin'] : null;
      _selectedElectrophorese = data['electrophorese']?.isNotEmpty == true ? data['electrophorese'] : null;
    }
    
    // Naviguer à la bonne page si nécessaire
    if (_currentStep > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.animateToPage(
          _currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _dateController.dispose();
    _numeroController.dispose();
    _emailController.dispose();
    _professionController.dispose();
    _adresseController.dispose();
    _nipController.dispose();
    _tailleController.dispose();
    _poidsController.dispose();
    _allergiesController.dispose();
    _vaccinationsController.dispose();
    _typeCouvertureController.dispose();
    _soinsInclusController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Widget pour row responsive
  Widget _buildResponsiveRow(List<Widget> children, {bool isMobile = false}) {
    if (isMobile) {
      return Column(
        children: children.map((child) => 
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: child,
          )
        ).toList(),
      );
    } else {
      List<Widget> rowChildren = [];
      for (int i = 0; i < children.length; i++) {
        rowChildren.add(Expanded(child: children[i]));
        if (i < children.length - 1) {
          rowChildren.add(const SizedBox(width: 16));
        }
      }
      return Row(children: rowChildren);
    }
  }

  // Widget dropdown stylisé
  Widget _buildStyledDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(
                  hint ?? 'Sélectionner $label',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500], size: 20),
                style: GoogleFonts.poppins(
                  color: Colors.grey[900],
                  fontSize: 14,
                ),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(item),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF00553E),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      String formattedDate = "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  void _showSoinsDialog() {
    List<String> availableSoins = [
      'consultations',
      'maternité',
      'chirurgie',
      'hospitalisation',
      'pharmacie',
      'dentaire',
      'optique',
      'laboratoire',
    ];
    
    List<String> currentSoins = _soinsInclusController.text.isNotEmpty
        ? _soinsInclusController.text.split(',').map((s) => s.trim()).toList()
        : [];
    
    Map<String, bool> selectedSoins = {};
    for (String soin in availableSoins) {
      selectedSoins[soin] = currentSoins.contains(soin);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Text('Sélectionner les soins inclus', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              content: Container(
                width: 300,
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: availableSoins.map((soin) {
                      return CheckboxListTile(
                        title: Text(soin, style: GoogleFonts.poppins()),
                        value: selectedSoins[soin],
                        onChanged: (bool? value) {
                          setDialogState(() {
                            selectedSoins[soin] = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF00553E),
                        dense: true,
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[600],
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text('Annuler', style: GoogleFonts.poppins()),
                ),
                ElevatedButton(
                  onPressed: () {
                    List<String> selected = selectedSoins.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();
                    
                    setState(() {
                      _soinsInclusController.text = selected.join(', ');
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00553E),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Ajouter', style: GoogleFonts.poppins()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showVaccinationDialog() {
    List<String> availableVaccinations = [
      'Varicelle',
      'BCG',
      'DTP',
      'MMR',
      'Hépatite',
      'HPV',
      'Hib',
      'Polio',
      'Fievre jaune',
      'COVID-19',
      'Méningite',
    ];
    
    List<String> currentVaccinations = _vaccinationsController.text.isNotEmpty
        ? _vaccinationsController.text.split(',').map((v) => v.trim()).toList()
        : [];
    
    Map<String, bool> selectedVaccinations = {};
    for (String vaccination in availableVaccinations) {
      selectedVaccinations[vaccination] = currentVaccinations.contains(vaccination);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Text('Sélectionner les vaccinations', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              content: Container(
                width: 300,
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: availableVaccinations.map((vaccination) {
                      return CheckboxListTile(
                        title: Text(vaccination, style: GoogleFonts.poppins()),
                        value: selectedVaccinations[vaccination],
                        onChanged: (bool? value) {
                          setDialogState(() {
                            selectedVaccinations[vaccination] = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF00553E),
                        dense: true,
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[600],
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text('Annuler', style: GoogleFonts.poppins()),
                ),
                ElevatedButton(
                  onPressed: () {
                    List<String> selected = selectedVaccinations.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();
                    
                    setState(() {
                      _vaccinationsController.text = selected.join(', ');
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00553E),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Ajouter', style: GoogleFonts.poppins()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool isDate = false, int maxLines = 1}) {
    return       Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        if (isDate)
          GestureDetector(
            onTap: _selectDate,
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.text.isEmpty ? 'Sélectionner une date' : controller.text,
                      style: GoogleFonts.poppins(
                        color: controller.text.isEmpty ? Colors.grey[500] : Colors.grey[700],
                      ),
                    ),
                  ),
                  Icon(Icons.calendar_today, size: 20, color: Colors.grey[500]),
                ],
              ),
            ),
          )
        else
                      Container(
            height: 35, 
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              style: GoogleFonts.poppins(color: Colors.grey[900], fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                fillColor: Colors.transparent,
                filled: true,
              ),
            ),
          ),
      ],
    );
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentStep == 2) {
      // À la dernière étape (assurance), naviguer vers le récapitulatif
      _savePatient();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _savePatient() {
    // Collecter toutes les données du formulaire
    Map<String, String> patientData = {
      'nom': _nomController.text,
      'prenom': _prenomController.text,
      'email': _emailController.text,
      'date': _dateController.text,
      'numero': _numeroController.text,
      'profession': _professionController.text,
      'adresse': _adresseController.text,
      'nip': _nipController.text,
      'taille': _tailleController.text,
      'groupe_sanguin': _selectedGroupeSanguin ?? '',
      'poids': _poidsController.text,
      'electrophorese': _selectedElectrophorese ?? '',
      'allergies': _allergiesController.text,
      'vaccinations': _vaccinationsController.text,
      'type_couverture': _typeCouvertureController.text,
      'soins_inclus': _soinsInclusController.text,
    };
    
    // Naviguer vers la page de récapitulatif
    context.go('/professional/recap-patient', extra: patientData);
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
            title: Text('Ajouter un patient', style: GoogleFonts.poppins()),
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
                    if (!isMobile) Text('Ajouter un patient', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                    if (!isMobile) const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => context.go('/professional/management'),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Color(0xFF00553E)),
                          const SizedBox(width: 8),
                          Text(isMobile ? 'Retour' : 'Retour à la gestion', style: GoogleFonts.poppins(color: Color(0xFF00553E))),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                    Text(
                      'Ajouter un dossier',
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Veuillez remplir toutes les informations',
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 32),
                    
                    // Contenu du formulaire
                    Container(
                      height: 450,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // Page 1: Informations personnelles
                          _buildPersonalInfoPage(),
                          // Page 2: Informations médicales
                          _buildMedicalInfoPage(),
                          // Page 3: Assurance
                          _buildAssurancePage(),
                        ],
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
      },
    );
  }

  Widget _buildPersonalInfoPage() {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Informations personnelles', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildResponsiveRow([
                      _buildInputField('Nom', _nomController),
                      _buildInputField('Prénom', _prenomController),
                      _buildInputField('Date de naissance', _dateController, isDate: true),
                    ], isMobile: isMobile),
                    const SizedBox(height: 16),
                    _buildResponsiveRow([
                      _buildInputField('Numéro', _numeroController),
                      _buildInputField('Email', _emailController),
                      _buildInputField('Profession', _professionController),
                    ], isMobile: isMobile),
                    const SizedBox(height: 16),
                    _buildResponsiveRow([
                      _buildInputField('Adresse', _adresseController),
                      _buildInputField('NIP', _nipController),
                    ], isMobile: isMobile),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Indicateur de progression
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
                        color: _currentStep >= 1 ? const Color(0xFF00553E) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentStep >= 2 ? const Color(0xFF00553E) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00553E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_currentStep == 2 ? 'Récapitulatif' : 'Suivant', style: GoogleFonts.poppins()),
                      const SizedBox(width: 8),
                      Icon(_currentStep == 2 ? Icons.summarize : Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalInfoPage() {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Informations médicales', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildResponsiveRow([
                      _buildInputField('Taille', _tailleController),
                      _buildStyledDropdown(
                        label: 'Groupe sanguin',
                        value: _selectedGroupeSanguin,
                        items: _groupesSanguins,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGroupeSanguin = newValue;
                          });
                        },
                      ),
                    ], isMobile: isMobile),
                    const SizedBox(height: 16),
                    _buildResponsiveRow([
                      _buildInputField('Poids', _poidsController),
                      _buildStyledDropdown(
                        label: 'Electrophorèse',
                        value: _selectedElectrophorese,
                        items: _electrophoreses,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedElectrophorese = newValue;
                          });
                        },
                      ),
                    ], isMobile: isMobile),
                    const SizedBox(height: 16),
                    _buildInputField('Allergies', _allergiesController, maxLines: 2),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Vaccinations', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: _showVaccinationDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00553E),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text('Ajouter', style: GoogleFonts.poppins(fontSize: 12)),
                            ),
                          ],
                        ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _vaccinationsController.text.isEmpty
                                    ? Text(
                                        'Cliquez sur "Ajouter" pour sélectionner les vaccinations',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                        ),
                                      )
                                    : Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: _vaccinationsController.text
                                            .split(',')
                                            .map((vaccination) => vaccination.trim())
                                            .where((vaccination) => vaccination.isNotEmpty)
                                            .map((vaccination) => Chip(
                                                  label: Text(
                                                    vaccination,
                                                    style: GoogleFonts.poppins(fontSize: 12),
                                                  ),
                                                  deleteIcon: const Icon(Icons.close, size: 16),
                                                  onDeleted: () {
                                                    List<String> currentVaccinations = _vaccinationsController.text
                                                        .split(',')
                                                        .map((v) => v.trim())
                                                        .where((v) => v.isNotEmpty)
                                                        .toList();
                                                    currentVaccinations.remove(vaccination);
                                                    setState(() {
                                                      _vaccinationsController.text = currentVaccinations.join(', ');
                                                    });
                                                  },
                                                  backgroundColor: Colors.white,
                                                  side: BorderSide(color: Colors.grey[300]!),
                                                ))
                                            .toList(),
                                      ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Indicateur de progression
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
                        color: _currentStep >= 1 ? const Color(0xFF00553E) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentStep >= 2 ? const Color(0xFF00553E) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _previousStep,
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
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00553E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_currentStep == 2 ? 'Récapitulatif' : 'Suivant', style: GoogleFonts.poppins()),
                      const SizedBox(width: 8),
                      Icon(_currentStep == 2 ? Icons.summarize : Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssurancePage() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assurance', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInputField('Type de couverture', _typeCouvertureController),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Soins inclus', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: _showSoinsDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00553E),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text('Ajouter', style: GoogleFonts.poppins(fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _soinsInclusController.text.isEmpty
                              ? Text(
                                  'Cliquez sur "Ajouter" pour sélectionner les soins inclus',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                )
                              : Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _soinsInclusController.text
                                      .split(',')
                                      .map((soin) => soin.trim())
                                      .where((soin) => soin.isNotEmpty)
                                      .map((soin) => Chip(
                                            label: Text(
                                              soin,
                                              style: GoogleFonts.poppins(fontSize: 12),
                                            ),
                                            deleteIcon: const Icon(Icons.close, size: 16),
                                            onDeleted: () {
                                              List<String> currentSoins = _soinsInclusController.text
                                                  .split(',')
                                                  .map((s) => s.trim())
                                                  .where((s) => s.isNotEmpty)
                                                  .toList();
                                              currentSoins.remove(soin);
                                              setState(() {
                                                _soinsInclusController.text = currentSoins.join(', ');
                                              });
                                            },
                                            backgroundColor: Colors.white,
                                            side: BorderSide(color: Colors.grey[300]!),
                                          ))
                                      .toList(),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Indicateur de progression
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
                        color: _currentStep >= 1 ? const Color(0xFF00553E) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentStep >= 2 ? const Color(0xFF00553E) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _previousStep,
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
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00553E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_currentStep == 2 ? 'Récapitulatif' : 'Suivant', style: GoogleFonts.poppins()),
                      const SizedBox(width: 8),
                      Icon(_currentStep == 2 ? Icons.summarize : Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 