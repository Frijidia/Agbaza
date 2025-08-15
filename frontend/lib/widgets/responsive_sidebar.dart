import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ResponsiveSidebar extends StatelessWidget {
  final String currentPage;
  final String userName;
  
  const ResponsiveSidebar({
    super.key,
    required this.currentPage,
    this.userName = 'Espoir AGOLI-AGBO',
  });

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

  Widget _buildFullSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // En-tête avec le nom d'utilisateur
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    userName,
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
                      child: _buildNotificationPopup(),
                    ),
                  ],
                  child: const Icon(Icons.notifications),
                ),
              ],
            ),
          ),
          const Divider(),
          // Menu items
          Builder(
            builder: (context) => Column(
              children: [
                _buildMenuItem(
                  context,
                  'Tableau de board',
                  '/professional/dashboard',
                  currentPage == 'dashboard',
                ),
                _buildMenuItem(
                  context,
                  'Gestion des patients',
                  '/professional/management',
                  currentPage == 'management',
                ),
              ],
            ),
          ),
          const Spacer(),
          // Bouton déconnexion en bas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              onTap: () {
                context.go('/professional/login');
              },
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Deconnexion',
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSidebar(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // User avatar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF00553E),
                  child: Text(
                    userName.substring(0, 1),
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.notifications),
              ],
            ),
          ),
          const Divider(),
          // Menu icons
          Builder(
            builder: (context) => Column(
              children: [
                _buildCompactMenuItem(
                  context,
                  Icons.dashboard,
                  '/professional/dashboard',
                  currentPage == 'dashboard',
                ),
                _buildCompactMenuItem(
                  context,
                  Icons.people,
                  '/professional/management',
                  currentPage == 'management',
                ),
              ],
            ),
          ),
          const Spacer(),
          // Logout icon
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              onPressed: () {
                context.go('/login');
              },
              icon: const Icon(Icons.logout, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String route, bool isSelected) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: const Color(0xFF00553E).withOpacity(0.1),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isSelected ? const Color(0xFF00553E) : null,
          fontWeight: isSelected ? FontWeight.w500 : null,
        ),
      ),
      onTap: () => context.go(route),
    );
  }

  Widget _buildCompactMenuItem(BuildContext context, IconData icon, String route, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00553E).withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () => context.go(route),
        icon: Icon(
          icon,
          color: isSelected ? const Color(0xFF00553E) : Colors.grey[600],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Détecter la taille d'écran
        final screenWidth = MediaQuery.of(context).size.width;
        
        if (screenWidth > 900) {
          // Desktop - sidebar complète
          return _buildFullSidebar(context);
        } else if (screenWidth > 600) {
          // Tablette - sidebar compacte
          return _buildCompactSidebar(context);
        } else {
          // Mobile - pas de sidebar (sera dans un drawer)
          return Container();
        }
      },
    );
  }

  // Méthode statique pour créer un drawer sur mobile
  static Widget buildDrawer(BuildContext context, String currentPage, {String userName = 'Georsmel GBEGAN'}) {
    return Drawer(
      child: ResponsiveSidebar(
        currentPage: currentPage,
        userName: userName,
      )._buildFullSidebar(context),
    );
  }
} 