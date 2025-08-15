import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/responsive_sidebar.dart';
import 'patient_detail_screen.dart';

class PatientManagementScreen extends StatefulWidget {
  const PatientManagementScreen({super.key});

  @override
  State<PatientManagementScreen> createState() => _PatientManagementScreenState();
}

class _PatientManagementScreenState extends State<PatientManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;
  int _selectedSort = 0;
  int _currentPage = 1;

  final List<Map<String, String>> _patients = List.generate(8, (i) => {
    'nip': '20308987897890',
    'nom': 'AGOLI-AGBO',
    'prenom': 'Espoir',
    'email': 'espoir@gmail.com',
    'date': '28/07/2025',
  });

  // Widget dropdown stylisé
  Widget _buildStyledDropdown<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
    String? hint,
    double? width,
  }) {
    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: hint != null 
            ? Text(
                hint,
                style: GoogleFonts.poppins(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              )
            : null,
          icon: Container(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 20),
          ),
          style: GoogleFonts.poppins(
            color: Colors.grey[800],
            fontSize: 14,
          ),
          items: items,
          onChanged: onChanged,
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
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
            title: Text('Gestion des patients', style: GoogleFonts.poppins()),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
                      vertical: isMobile ? 16 : 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile) Text('Gestion des patients', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                        if (!isMobile) const SizedBox(height: 16),
                      // Barre de recherche
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: isMobile ? 'Rechercher...' : 'Rechercher un patient en saisissant son nom ou son NIP',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00553E),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Icon(Icons.search, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Filtres et bouton d'ajout
                      if (isMobile) ...[
                        // Version mobile - éléments empilés
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStyledDropdown<int>(
                                    value: _selectedFilter,
                                    items: [
                                      DropdownMenuItem(value: 0, child: Text('30 jours', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                      DropdownMenuItem(value: 2, child: Text('03 mois', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                      DropdownMenuItem(value: 3, child: Text('06 mois', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                      DropdownMenuItem(value: 1, child: Text('09 jours', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                    ],
                                    onChanged: (v) => setState(() => _selectedFilter = v!),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildStyledDropdown<int>(
                                    value: _selectedSort,
                                    items: [
                                      DropdownMenuItem(value: 0, child: Text('Derniers ajouts', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                      DropdownMenuItem(value: 1, child: Text('Ordre alphabétique', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                      DropdownMenuItem(value: 2, child: Text('Age croissant', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                      DropdownMenuItem(value: 3, child: Text('Age décroissant', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                     ],
                                    onChanged: (v) => setState(() => _selectedSort = v!),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => context.go('/professional/add-patient'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00553E),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add, color: Colors.white, size: 18),
                                    const SizedBox(width: 6),
                                    Text('Ajouter un patient', style: GoogleFonts.poppins(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        // Version desktop/tablette - éléments en ligne
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              child: _buildStyledDropdown<int>(
                                value: _selectedFilter,
                                items: [
                                  DropdownMenuItem(value: 0, child: Text('30 jours', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                  DropdownMenuItem(value: 2, child: Text('03 mois', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                  DropdownMenuItem(value: 3, child: Text('06 mois', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                  DropdownMenuItem(value: 1, child: Text('09 jours', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                ],
                                onChanged: (v) => setState(() => _selectedFilter = v!),
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 180,
                              child: _buildStyledDropdown<int>(
                                value: _selectedSort,
                                items: [
                                  DropdownMenuItem(value: 0, child: Text('Derniers ajouts', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                  DropdownMenuItem(value: 1, child: Text('Ordre alphabétique', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                  DropdownMenuItem(value: 2, child: Text('Age croissant', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                  DropdownMenuItem(value: 3, child: Text('Age décroissant', style: GoogleFonts.poppins(fontSize: 14), overflow: TextOverflow.ellipsis)),
                                 ],
                                onChanged: (v) => setState(() => _selectedSort = v!),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => context.go('/professional/add-patient'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00553E),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.add, color: Colors.white, size: 18),
                                    const SizedBox(width: 8),
                                    Text('Ajouter un patient', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 8)],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: isMobile 
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(minWidth: 600),
                                          child: DataTable(
                                            columnSpacing: 24,
                                            horizontalMargin: 16,
                                            columns: [
                                              DataColumn(label: Text('NIP', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                                              DataColumn(label: Text('Nom', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                                              DataColumn(label: Text('Prenom', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                                              DataColumn(label: Text('Email', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                                              DataColumn(label: Text('Date d\'ajout', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                                              DataColumn(label: Text('')),
                                            ],
                                            rows: _patients.map((p) => DataRow(
                                              cells: [
                                                DataCell(Text(p['nip'] ?? '', style: GoogleFonts.poppins())),
                                                DataCell(Text(p['nom'] ?? '', style: GoogleFonts.poppins())),
                                                DataCell(Text(p['prenom'] ?? '', style: GoogleFonts.poppins())),
                                                DataCell(Text(p['email'] ?? '', style: GoogleFonts.poppins())),
                                                DataCell(Text(p['date'] ?? '', style: GoogleFonts.poppins())),
                                                DataCell(
                                                  GestureDetector(
                                                    onTap: () => context.go('/professional/patient-detail', extra: p),
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF00553E),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text('Voir', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )).toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        width: double.infinity,
                                        child: DataTable(
                                          columnSpacing: isDesktop ? 40 : 24,
                                          horizontalMargin: 24,
                                          headingRowHeight: 56,
                                          dataRowHeight: 60,
                                          columns: [
                                            DataColumn(
                                              label: Container(
                                                width: isDesktop ? 150 : null,
                                                child: Text('NIP', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Container(
                                                width: isDesktop ? 120 : null,
                                                child: Text('Nom', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Container(
                                                width: isDesktop ? 100 : null,
                                                child: Text('Prénom', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text('Email', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                                            ),
                                            DataColumn(
                                              label: Container(
                                                width: isDesktop ? 120 : null,
                                                child: Text('Date d\'ajout', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                                              ),
                                            ),
                                            DataColumn(label: Text('')),
                                          ],
                                        rows: _patients.map((p) => DataRow(
                                          cells: [
                                            DataCell(
                                              Container(
                                                width: isDesktop ? 150 : null,
                                                child: GestureDetector(
                                                  onTap: () => context.go('/professional/patient-detail', extra: p),
                                                  child: Text(
                                                    p['nip']!,
                                                    style: GoogleFonts.poppins(fontSize: 14),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                width: isDesktop ? 120 : null,
                                                child: GestureDetector(
                                                  onTap: () => context.go('/professional/patient-detail', extra: p),
                                                  child: Text(
                                                    p['nom']!,
                                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                width: isDesktop ? 100 : null,
                                                child: GestureDetector(
                                                  onTap: () => context.go('/professional/patient-detail', extra: p),
                                                  child: Text(
                                                    p['prenom']!,
                                                    style: GoogleFonts.poppins(fontSize: 14),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              GestureDetector(
                                                onTap: () => context.go('/professional/patient-detail', extra: p),
                                                child: Text(
                                                  p['email']!,
                                                  style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF00553E)),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                width: isDesktop ? 120 : null,
                                                child: GestureDetector(
                                                  onTap: () => context.go('/professional/patient-detail', extra: p),
                                                  child: Text(
                                                    p['date']!,
                                                    style: GoogleFonts.poppins(fontSize: 14),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              GestureDetector(
                                                onTap: () => context.go('/professional/patient-detail', extra: p),
                                                child: const Icon(Icons.chevron_right, color: Color(0xFF00553E)),
                                              ),
                                            ),
                                          ],
                                        )).toList(),
                                        ),
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.chevron_left),
                                    onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                                  ),
                                  Text('$_currentPage', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                                  IconButton(
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: () => setState(() => _currentPage++),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ],
          ),
          backgroundColor: const Color(0xFFF6F6F6),
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
