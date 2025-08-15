import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HospitalMapScreen extends StatefulWidget {
  const HospitalMapScreen({super.key});

  @override
  State<HospitalMapScreen> createState() => _HospitalMapScreenState();
}

class _HospitalMapScreenState extends State<HospitalMapScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'LITS';
  
  // Flutter Map controller
  final MapController _mapController = MapController();
  
  // Position du Bénin (Cotonou)
  final LatLng _beninCenter = LatLng(6.3703, 2.3912);
  
  // Marqueurs des hôpitaux
  List<Marker> _markers = [];

  // Données simulées des hôpitaux
  final List<Map<String, dynamic>> _hospitals = [
    {
      'nom': 'CLINIC DON DE DIEU',
      'adresse': '98 RUE DE RIVOLI',
      'codePostal': '75001 Cotonou',
      'distance': '118 m',
      'services': ['LITS', 'SANGUE DE SANG', 'PRODUIT'],
    },
    {
      'nom': 'CLINIC DON DE DIEU',
      'adresse': '98 RUE DE RIVOLI',
      'codePostal': '75001 Cotonou',
      'distance': '118 m',
      'services': ['LITS', 'SANGUE DE SANG', 'PRODUIT'],
    },
    {
      'nom': 'CLINIC DON DE DIEU',
      'adresse': '98 RUE DE RIVOLI',
      'codePostal': '75001 Cotonou',
      'distance': '118 m',
      'services': ['LITS', 'SANGUE DE SANG', 'PRODUIT'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initializeMarkers() {
    _markers = [
      Marker(
        point: LatLng(6.3703, 2.3912), // Cotonou
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showHospitalInfo('CLINIC DON DE DIEU', 'Cotonou'),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF00553E),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      Marker(
        point: LatLng(6.4968, 2.6280), // Porto-Novo
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showHospitalInfo('CLINIC DON DE DIEU', 'Porto-Novo'),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF00553E),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      Marker(
        point: LatLng(9.3373, 2.6308), // Parakou
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showHospitalInfo('CLINIC DON DE DIEU', 'Parakou'),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF00553E),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    ];
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
                        _buildMenuItem('Gestion des produits', false),
                        _buildMenuItem('Carte', true),
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
            child: Row(
              children: [
                // Panneau gauche avec liste des hôpitaux
                Container(
                  width: 400,
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Header avec recherche
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo et titre
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00553E),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.local_hospital,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'agbaza',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF00553E),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00553E),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 20),
                            
                            // Barre de recherche
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Rechercher',
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
                            
                            SizedBox(height: 16),
                            
                            // Filtres
                            Row(
                              children: [
                                _buildFilterChip('LITS', _selectedFilter == 'LITS'),
                                SizedBox(width: 8),
                                _buildFilterChip('BANQUE DE SANG', _selectedFilter == 'BANQUE DE SANG'),
                                SizedBox(width: 8),
                                _buildFilterChip('PRODUIT', _selectedFilter == 'PRODUIT'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Liste des hôpitaux
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: _hospitals.length,
                          itemBuilder: (context, index) {
                            return _buildHospitalCard(_hospitals[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Flutter Map à droite
                Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        // Flutter Map
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: _beninCenter,
                            initialZoom: 7.0,
                            minZoom: 5.0,
                            maxZoom: 18.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.agbaza',
                            ),
                            MarkerLayer(
                              markers: _markers,
                            ),
                          ],
                        ),
                        
                        // Contrôles de zoom
                        Positioned(
                          right: 20,
                          bottom: 100,
                          child: Column(
                            children: [
                              _buildZoomButton(Icons.add, () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1)),
                              SizedBox(height: 8),
                              _buildZoomButton(Icons.remove, () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1)),
                            ],
                          ),
                        ),
                        
                        // Bouton de localisation personnalisé
                        Positioned(
                          right: 20,
                          bottom: 40,
                          child: FloatingActionButton(
                            onPressed: _goToMyLocation,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.my_location,
                              color: Color(0xFF00553E),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF00553E) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalCard(Map<String, dynamic> hospital) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hospital['nom'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00553E),
            ),
          ),
          SizedBox(height: 8),
          Text(
            hospital['adresse'],
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            hospital['codePostal'],
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            hospital['distance'],
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (hospital['services'] as List<String>).map((service) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  service,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _goToMyLocation() {
    _mapController.move(_beninCenter, 12.0);
  }

  void _showHospitalInfo(String name, String city) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text(
          '98 RUE DE RIVOLI\n75001 $city\n118 m',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer', style: GoogleFonts.poppins(color: Color(0xFF00553E))),
          ),
        ],
      ),
    );
  }

  Widget _buildZoomButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Color(0xFF00553E),
          size: 20,
        ),
      ),
    );
  }
}
