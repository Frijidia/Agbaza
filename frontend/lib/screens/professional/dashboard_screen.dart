import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
//import 'package:frontend/screens/minister/login_minister_screen.dart';

enum StatisticsType {
  platform,
  population,
  epidemic
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StatisticsType _currentType = StatisticsType.platform;
  String _selectedPeriod = '30 jours';
  final List<String> _periods = ['7 jours', '14 jours', '30 jours', '90 jours'];

  List<Map<String, dynamic>> _getCurrentStats() {
    switch (_currentType) {
      case StatisticsType.platform:
        return [
          {
            'icon': Icons.people_outline,
            'title': '125 000',
            'subtitle': 'inscrit',
            'trend': 12,
            'trendUp': true,
            'alertable': false,
          },
          {
            'icon': Icons.local_hospital_outlined,
            'title': '1630',
            'subtitle': 'structure créée',
            'trend': null,
            'alertable': false,
          },
          {
            'icon': Icons.folder_outlined,
            'title': '560',
            'subtitle': 'dossiers modifiés',
            'alertable': false,
          },
        ];
      case StatisticsType.population:
        return [
          {
            'icon': Icons.people_outline,
            'title': '65 %',
            'subtitle': 'en zone rurale',
            'trend': 12,
            'trendUp': true,
            'alertable': false,
          },
          {
            'icon': Icons.medical_services_outlined,
            'title': '28 %',
            'subtitle': 'En cours de traitement',
            'trend': 60,
            'trendUp': false,
            'alertable': true,
          },
          {
            'icon': Icons.receipt_long_outlined,
            'title': '07 %',
            'subtitle': 'de décès',
            'trend': 12,
            'trendUp': false,
            'alertable': true,
          },
          {
            'icon': Icons.health_and_safety_outlined,
            'title': '42 %',
            'subtitle': 'guéris',
            'trend': 8,
            'trendUp': true,
            'alertable': false,
          },
        ];
      case StatisticsType.epidemic:
        return [
          {
            'icon': Icons.coronavirus_outlined,
            'title': '3 250',
            'subtitle': 'cas actifs',
            'trend': 5,
            'trendUp': false,
            'alertable': true,
            'disease': 'Paludisme',
          },
          {
            'icon': Icons.local_hospital_outlined,
            'title': '185',
            'subtitle': 'hospitalisations',
            'trend': 3,
            'trendUp': true,
            'alertable': true,
            'disease': 'Grippe',
          },
          {
            'icon': Icons.healing_outlined,
            'title': '89%',
            'subtitle': 'taux de guérison',
            'trend': 2,
            'trendUp': true,
            'alertable': false,
          },
        ];
    }
  }

  void _changeType(StatisticsType type) {
    setState(() {
      _currentType = type;
    });
  }

  void _changePeriod(String period) {
    setState(() {
      _selectedPeriod = period;
    });
  }

  void _showAlertDialog(BuildContext context, Map<String, dynamic> stat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Les citoyens inscrits sur la plateforme ainsi que les médecins et membres du ministère recevront une alerte préventive concernant cette donnée.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color(0xFF00553E)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            ),
            child: Text(
              'Annuler',
              style: GoogleFonts.poppins(
                color: const Color(0xFF00553E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _sendAlert(context, stat);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00553E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(
              'Envoyer',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendAlert(BuildContext context, Map<String, dynamic> stat) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alerte envoyée pour ${stat['title']}',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF00553E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 900;

        return Scaffold(
          body: Builder(
            builder: (context) {
              if (isDesktop) {
                return Row(
                  children: [
                    // Barre latérale gauche
                    Container(
                      width: 250,
                      color: Colors.white,
                      child: _SidebarContent(),
                    ),
                    // Contenu principal
                    Expanded(
                      child: _MainContent(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(24.0),
                        currentType: _currentType,
                        selectedPeriod: _selectedPeriod,
                        periods: _periods,
                        stats: _getCurrentStats(),
                        onTypeChanged: _changeType,
                        onPeriodChanged: _changePeriod,
                        onAlertPressed: _showAlertDialog,
                      ),
                    ),
                  ],
                );
              } else if (isTablet) {
                return Row(
                  children: [
                    // Barre latérale réduite
                    Container(
                      width: 80,
                      color: Colors.white,
                      child: _CompactSidebarContent(),
                    ),
                    // Contenu principal
                    Expanded(
                      child: _MainContent(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(16.0),
                        currentType: _currentType,
                        selectedPeriod: _selectedPeriod,
                        periods: _periods,
                        stats: _getCurrentStats(),
                        onTypeChanged: _changeType,
                        onPeriodChanged: _changePeriod,
                        onAlertPressed: _showAlertDialog,
                      ),
                    ),
                  ],
                );
              } else {
                // Vue mobile
                return Column(
                  children: [
                    // App bar mobile
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Georsrmel GBEGAN',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.notifications),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => _NotificationPopup(),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Contenu principal
                    Expanded(
                      child: _MainContent(
                        crossAxisCount: 1,
                        padding: const EdgeInsets.all(16.0),
                        currentType: _currentType,
                        selectedPeriod: _selectedPeriod,
                        periods: _periods,
                        stats: _getCurrentStats(),
                        onTypeChanged: _changeType,
                        onPeriodChanged: _changePeriod,
                        onAlertPressed: _showAlertDialog,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          // Drawer pour mobile et tablette
          drawer: !isDesktop ? Drawer(
            child: _SidebarContent(),
          ) : null,
        );
      },
    );
  }
}

class _SidebarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // En-tête avec le nom d'utilisateur
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Espoir AGOLI-AGBO',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
              PopupMenuButton(
                offset: const Offset(0, 40),
                position: PopupMenuPosition.under,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: _NotificationPopup(),
                  ),
                ],
                child: const Icon(Icons.notifications),
              ),
            ],
          ),
        ),
        const Divider(),
        // Menu items
        ListTile(
          selected: true,
          selectedTileColor: const Color(0xFF00553E).withOpacity(0.1),
          title: Text(
            'Tableau de board',
            style: GoogleFonts.poppins(
              color: const Color(0xFF00553E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Gestion des patients',
            style: GoogleFonts.poppins(),
          ),
          onTap: () => context.go('/professional/management'),
        ),
        const Spacer(),
        // Bouton déconnexion en bas
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            onTap: () {
          // Logique de déconnexion ici
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Déconnecté avec succès',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: const Color(0xFF00553E),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            // Utilisation de GoRouter pour la navigation
            // ignore: use_build_context_synchronously
            context.go('/professional/login', extra: 'logout_success');
          });
        },
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Deconnexion',
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactSidebarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        IconButton(
          icon: const Icon(Icons.dashboard),
          color: const Color(0xFF00553E),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.announcement),
          onPressed: () {},
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _MainContent extends StatefulWidget {
  final int crossAxisCount;
  final EdgeInsets padding;
  final StatisticsType currentType;
  final String selectedPeriod;
  final List<String> periods;
  final List<Map<String, dynamic>> stats;
  final Function(StatisticsType) onTypeChanged;
  final Function(String) onPeriodChanged;
  final Function(BuildContext, Map<String, dynamic>) onAlertPressed;

  const _MainContent({
    required this.crossAxisCount,
    required this.padding,
    required this.currentType,
    required this.selectedPeriod,
    required this.periods,
    required this.stats,
    required this.onTypeChanged,
    required this.onPeriodChanged,
    required this.onAlertPressed,
  });

  @override
  State<_MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<_MainContent> {
  int? _alertIndex;

  void _showAlertButton(int index) {
    setState(() {
      _alertIndex = index;
    });
  }

  void _hideAlertButton() {
    setState(() {
      _alertIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tableau de board',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          // Filtres
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  selected: widget.currentType == StatisticsType.platform,
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFF00553E),
                  showCheckmark: false,
                  label: Text(
                    'Statistique de la plateforme',
                    style: GoogleFonts.poppins(
                      color: widget.currentType == StatisticsType.platform 
                          ? Colors.white 
                          : const Color(0xFF00553E),
                    ),
                  ),
                  onSelected: (_) => widget.onTypeChanged(StatisticsType.platform),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  selected: widget.currentType == StatisticsType.population,
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFF00553E),
                  showCheckmark: false,
                  label: Text(
                    'Statistique de la population',
                    style: GoogleFonts.poppins(
                      color: widget.currentType == StatisticsType.population 
                          ? Colors.white 
                          : const Color(0xFF00553E),
                    ),
                  ),
                  onSelected: (_) => widget.onTypeChanged(StatisticsType.population),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  selected: widget.currentType == StatisticsType.epidemic,
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFF00553E),
                  showCheckmark: false,
                  label: Text(
                    'Statistique épidémie',
                    style: GoogleFonts.poppins(
                      color: widget.currentType == StatisticsType.epidemic 
                          ? Colors.white 
                          : const Color(0xFF00553E),
                    ),
                  ),
                  onSelected: (_) => widget.onTypeChanged(StatisticsType.epidemic),
                ),
                const SizedBox(width: 12),
                PopupMenuButton<String>(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.selectedPeriod,
                          style: GoogleFonts.poppins(),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => widget.periods
                      .map((period) => PopupMenuItem(
                            value: period,
                            child: Text(
                              period,
                              style: GoogleFonts.poppins(),
                            ),
                          ))
                      .toList(),
                  onSelected: widget.onPeriodChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Cartes de statistiques avec animation
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: GridView.count(
                key: ValueKey(widget.currentType),
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: widget.crossAxisCount == 1 ? 1.5 : 2,
                children: List.generate(widget.stats.length, (index) {
                  final stat = widget.stats[index];
                  return Column(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: stat['icon'],
                          title: stat['title'],
                          subtitle: stat['subtitle'],
                          trend: stat['trend'],
                          trendUp: stat['trendUp'] ?? true,
                          alertable: stat['alertable'] ?? false,
                          onAlertIconPressed: stat['alertable'] == true
                              ? () {
                                  if (_alertIndex == index) {
                                    _hideAlertButton();
                                  } else {
                                    _showAlertButton(index);
                                  }
                                }
                              : null,
                        ),
                      ),
                      if (_alertIndex == index && stat['alertable'] == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[100],
                                foregroundColor: Colors.red[700],
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                widget.onAlertPressed(context, stat);
                                _hideAlertButton();
                              },
                              child: Text(
                                "Lancer un message d'alerte",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int? trend;
  final bool trendUp;
  final bool alertable;
  final VoidCallback? onAlertIconPressed;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trend,
    this.trendUp = true,
    this.alertable = false,
    this.onAlertIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF00553E)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (trend != null) ...[
                    const SizedBox(width: 8),
                    Icon(
                      trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 16,
                      color: trendUp ? Colors.green[700] : Colors.red[700],
                    ),
                    Text(
                      ' $trend%',
                      style: GoogleFonts.poppins(
                        color: trendUp ? Colors.green[700] : Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          if (alertable)
            Positioned(
              top: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onAlertIconPressed,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.warning_outlined,
                      size: 20,
                      color: Colors.orange[700],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
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