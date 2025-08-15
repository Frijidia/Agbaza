import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/responsive_sidebar.dart';

class PatientDetailScreen extends StatefulWidget {
  final Map<String, String> patient;
  const PatientDetailScreen({super.key, required this.patient});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  bool _isEditing = false;
  late Map<String, TextEditingController> _controllers;
  late Map<String, String> _originalData;

  @override
  void initState() {
    super.initState();
    _originalData = Map.from(widget.patient);
    _controllers = {
      'email': TextEditingController(text: widget.patient['email']),
      'date': TextEditingController(text: widget.patient['date']),
      'phone': TextEditingController(text: widget.patient['phone']),
      'profession': TextEditingController(text: widget.patient['profession']),
      'address': TextEditingController(text: widget.patient['address']),
      'height': TextEditingController(text: widget.patient['height']),
      'blood_group': TextEditingController(text: widget.patient['blood_group']),
      'weight': TextEditingController(text: widget.patient['weight']),
      'electrophoresis': TextEditingController(text: widget.patient['electrophoresis']),
      'allergies': TextEditingController(text: widget.patient['allergies']),
      'vaccinations': TextEditingController(text: widget.patient['vaccinations']),
    };
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Souhaitez-vous conserver les modifications apportées ?',
                style: GoogleFonts.poppins(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveChanges();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00553E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Conserver', style: GoogleFonts.poppins()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _cancelChanges();
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                        side: BorderSide(color: Colors.grey[300]!),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Annuler', style: GoogleFonts.poppins()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Modifications sauvegardées avec succès', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF00553E),
      ),
    );
  }

  void _cancelChanges() {
    setState(() {
      _isEditing = false;
      // Restaurer les valeurs originales
      _controllers.forEach((key, controller) {
        controller.text = _originalData[key] ?? '';
      });
    });
  }

  void _showConsultationHistory() {
    List<Map<String, String>> consultationHistory = [
      {
        'date': '27 Juin 2025',
        'doctor': 'Dr GAHITO Nukonklu',
        'type': 'Consultation générale',
      },
      {
        'date': '20 Juin 2025',
        'doctor': 'Dr GAHITO Nukonklu',
        'type': 'Suivi médical',
      },
      {
        'date': '15 Mai 2025',
        'doctor': 'Dr GAHITO Nukonklu',
        'type': 'Consultation spécialisée',
      },
      {
        'date': '10 Avril 2025',
        'doctor': 'Dr GAHITO Nukonklu',
        'type': 'Contrôle de routine',
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: 400,
            height: 500,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Historique de consultation',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: consultationHistory.map((consultation) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            context.go('/professional/consultation-history', extra: {
                              'patient': widget.patient,
                              'consultation': consultation,
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      consultation['date']!,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00553E).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        consultation['type']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: const Color(0xFF00553E),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.person, size: 16, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Text(
                                      consultation['doctor']!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.chevron_right, color: Color(0xFF00553E)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00553E),
                      side: const BorderSide(color: Color(0xFF00553E)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Fermer', style: GoogleFonts.poppins()),
                  ),
                ),
              ],
            ),
          ),
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
    
    List<String> currentVaccinations = (_controllers['vaccinations']?.text ?? '')
        .split(',')
        .map((v) => v.trim())
        .where((v) => v.isNotEmpty)
        .toList();
    
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
                      _controllers['vaccinations']?.text = selected.join(', ');
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
        _controllers['date']?.text = formattedDate;
      });
    }
  }

  Widget _buildEditableField(String value, String key, {int maxLines = 1}) {
    if (_isEditing && _controllers.containsKey(key)) {
      if (key == 'date') {
        return GestureDetector(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _controllers[key]?.text ?? value,
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[500]),
              ],
            ),
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: _controllers[key],
            maxLines: maxLines,
            style: GoogleFonts.poppins(color: Colors.grey[600]),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              fillColor: Colors.transparent,
            ),
          ),
        );
      }
    } else {
      return Text(value, style: GoogleFonts.poppins(color: Colors.grey[600]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth <= 600;

        return Scaffold(
          appBar: isMobile ? AppBar(
            title: Text('Détail du patient', style: GoogleFonts.poppins()),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
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
                  horizontal: isMobile ? 16 : 32,
                  vertical: isMobile ? 16 : 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  if (!isMobile) Text('Détail du patient', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                  if (!isMobile) const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => context.go('/professional/management'),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back, color: Color(0xFF00553E)),
                        const SizedBox(width: 8),
                        Text(isMobile ? 'Retour' : 'Retour à la liste', style: GoogleFonts.poppins(color: Color(0xFF00553E))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Espoir AGOLI-AGBO',
                              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  widget.patient['nip'] ?? '',
                                  style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Copier le NIP dans le presse-papiers
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('NIP copié dans le presse-papiers'),
                                        backgroundColor: const Color(0xFF00553E),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.copy, size: 16, color: Color(0xFF00553E)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_isEditing) {
                            _showSaveDialog();
                          } else {
                            _toggleEdit();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00553E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        icon: Icon(_isEditing ? Icons.save : Icons.edit, size: 18),
                        label: Text(_isEditing ? 'Enregistrer' : 'Modifier le dossier', style: GoogleFonts.poppins()),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: _showConsultationHistory,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF00553E),
                          side: const BorderSide(color: Color(0xFF00553E)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        icon: const Icon(Icons.calendar_today, size: 18),
                        label: Text('Historique de consultation', style: GoogleFonts.poppins()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
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
                                              _buildEditableField(widget.patient['email'] ?? '', 'email'),
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
                                              _buildEditableField(widget.patient['date'] ?? '', 'date'),
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
                                              _buildEditableField(widget.patient['phone'] ?? '', 'phone'),
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
                                              _buildEditableField(widget.patient['profession'] ?? '', 'profession'),
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
                                        _buildEditableField(widget.patient['address'] ?? '', 'address'),
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
                                              _isEditing 
                                                ? Row(
                                                    children: [
                                                      Expanded(child: _buildEditableField(widget.patient['height'] ?? '', 'height')),
                                                      const SizedBox(width: 4),
                                                      Text('cm', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                    ],
                                                  )
                                                : Text('${widget.patient['height']} cm', style: GoogleFonts.poppins(color: Colors.grey[600])),
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
                                              _buildEditableField(widget.patient['blood_group'] ?? '', 'blood_group'),
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
                                              _isEditing 
                                                ? Row(
                                                    children: [
                                                      Expanded(child: _buildEditableField(widget.patient['weight'] ?? '', 'weight')),
                                                      const SizedBox(width: 4),
                                                      Text('kg', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                                    ],
                                                  )
                                                : Text('${widget.patient['weight']} kg', style: GoogleFonts.poppins(color: Colors.grey[600])),
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
                                              _buildEditableField(widget.patient['electrophoresis'] ?? '', 'electrophoresis'),
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
                                        _buildEditableField(widget.patient['allergies'] ?? '', 'allergies', maxLines: 2),
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
                  const SizedBox(height: 24),
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
                                                                        Row(
                                      children: [
                                        Text('Vaccinations', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                        if (_isEditing) ...[
                                          const SizedBox(width: 8),
                                          const Icon(Icons.warning, color: Colors.orange, size: 16),
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
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    _isEditing 
                                      ? _buildEditableField(_controllers['vaccinations']?.text ?? '', 'vaccinations', maxLines: 2)
                                      : Wrap(
                                          spacing: 12,
                                          runSpacing: 8,
                                          children: (widget.patient['vaccinations'] ?? 'Polio,Fievre jaune,COVID-19')
                                              .split(',')
                                              .map((vaccination) => Chip(
                                                label: Text(vaccination.trim(), style: GoogleFonts.poppins(fontSize: 12)),
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
                                                                           Row(
                                         children: [
                                           Text('Couverture AMO', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                           const SizedBox(width: 16),
                                           Expanded(
                                             child: Container(
                                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                               decoration: BoxDecoration(
                                                 border: Border.all(color: Colors.grey[300]!),
                                                 borderRadius: BorderRadius.circular(8),
                                                 color: Colors.grey[50],
                                               ),
                                               child: DropdownButtonHideUnderline(
                                                 child: DropdownButton<String>(
                                                   value: 'Soins inclus',
                                                   isExpanded: true,
                                                   items: ['Soins inclus', 'Soins partiels', 'Pas de couverture']
                                                       .map((String value) {
                                                     return DropdownMenuItem<String>(
                                                       value: value,
                                                       child: Text(value, style: GoogleFonts.poppins(color: Colors.grey[700])),
                                                     );
                                                   }).toList(),
                                                   onChanged: (String? newValue) {},
                                                   style: GoogleFonts.poppins(color: Colors.grey[700]),
                                                 ),
                                               ),
                                             ),
                                           ),
                                         ],
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
                                      Row(
                                        children: [
                                          Text('Vaccinations', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                          if (_isEditing) ...[
                                            const SizedBox(width: 8),
                                            const Icon(Icons.warning, color: Colors.orange, size: 16),
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
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      _isEditing 
                                        ? _buildEditableField(_controllers['vaccinations']?.text ?? '', 'vaccinations', maxLines: 2)
                                        : Wrap(
                                            spacing: 12,
                                            runSpacing: 8,
                                            children: (widget.patient['vaccinations'] ?? 'Polio,Fievre jaune,COVID-19')
                                                .split(',')
                                                .map((vaccination) => Chip(
                                                  label: Text(vaccination.trim(), style: GoogleFonts.poppins(fontSize: 12)),
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
                                      Row(
                                        children: [
                                          Text('Couverture AMO', style: GoogleFonts.poppins(color: Colors.grey[600])),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey[300]!),
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.grey[50],
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: 'Soins inclus',
                                                  isExpanded: true,
                                                  items: ['Soins inclus', 'Soins partiels', 'Pas de couverture']
                                                      .map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value, style: GoogleFonts.poppins(color: Colors.grey[700])),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {},
                                                  style: GoogleFonts.poppins(color: Colors.grey[700]),
                                                ),
                                              ),
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
                        );
                      }
                    },
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

class _NotificationPopup extends StatefulWidget {
  @override
  State<_NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<_NotificationPopup> {
  String _selectedTab = 'all';

  void _onTabSelected(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Centre de notifications',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(height: 1),
          // Onglets
          Row(
            children: [
              Expanded(
                child: _NotificationTab(
                  label: 'Toutes',
                  isSelected: _selectedTab == 'all',
                  onTap: () => _onTabSelected('all'),
                ),
              ),
              Expanded(
                child: _NotificationTab(
                  label: 'Non lues',
                  isSelected: _selectedTab == 'unread',
                  onTap: () => _onTabSelected('unread'),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          // Action pour marquer comme lues
          TextButton(
            onPressed: () {
              // Ajouter ici la logique pour marquer toutes les notifications comme lues
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Toutes les notifications ont été marquées comme lues',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: const Color(0xFF00553E),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF00553E),
              padding: const EdgeInsets.all(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Tout marquer comme lu',
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Message quand il n'y a pas de notifications
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.notifications_off_outlined,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucune notification',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vous serez notifié des nouvelles activités',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NotificationTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? const Color(0xFF00553E) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: isSelected ? const Color(0xFF00553E) : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
