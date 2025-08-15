import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HospitalRegisterDocumentsScreen extends StatefulWidget {
  const HospitalRegisterDocumentsScreen({super.key});

  @override
  State<HospitalRegisterDocumentsScreen> createState() => _HospitalRegisterDocumentsScreenState();
}

class _HospitalRegisterDocumentsScreenState extends State<HospitalRegisterDocumentsScreen> {
  String? _uploadedFileName;
  bool _isUploading = false;

  void _uploadFile() {
    setState(() {
      _isUploading = true;
    });

    // Simuler un téléchargement
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isUploading = false;
        _uploadedFileName = 'carte_professionnel.pdf (146 kb)';
      });
    });
  }

  void _removeFile() {
    setState(() {
      _uploadedFileName = null;
    });
  }

  void _nextStep() {
    if (_uploadedFileName != null) {
      context.go('/hospital/register-success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Partie gauche avec le formulaire
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 120,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
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
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00553E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  
                  // Bouton retour
                  GestureDetector(
                    onTap: () => context.go('/hospital/register-security'),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Color(0xFF00553E), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Retour',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF00553E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Titre
                  Text(
                    'Créer le compte de l\'établissement',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Documents justificatifs',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Description
                  Text(
                    'PDF ou image - Agrément ou autorisation d\'exercer (Obligatoire)',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Zone de téléchargement
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _uploadedFileName != null
                        ? _buildUploadedFile()
                        : _buildUploadArea(),
                  ),
                  
                  SizedBox(height: 40),

                  // Bouton suivant et indicateur de progression
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _uploadedFileName != null ? _nextStep : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _uploadedFileName != null 
                                ? Color(0xFF00553E) 
                                : Colors.grey[300],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Suivant',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      // Indicateur de progression (4/5)
                      Row(
                        children: [
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Color(0xFF00553E)),
                          SizedBox(width: 6),
                          Container(width: 48, height: 4, color: Colors.grey[300]),
                        ],
                      ),
                    ],
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Partie droite avec l'image
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/hopital_img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isUploading) ...[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00553E)),
          ),
          SizedBox(height: 16),
          Text(
            'Téléchargement en cours...',
            style: GoogleFonts.poppins(color: Colors.grey[600]),
          ),
        ] else ...[
          Icon(
            Icons.file_download_outlined,
            size: 48,
            color: Color(0xFF00553E),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: _uploadFile,
            child: Text(
              'Importer un fichier (5 MB maximum)',
              style: GoogleFonts.poppins(
                color: Color(0xFF00553E),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUploadedFile() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  _uploadedFileName!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _removeFile,
                child: Icon(
                  Icons.close,
                  color: Colors.grey[600],
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}