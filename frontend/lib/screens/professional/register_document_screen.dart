import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class RegisterDocumentScreen extends StatefulWidget {
  const RegisterDocumentScreen({super.key});

  @override
  State<RegisterDocumentScreen> createState() => _RegisterDocumentScreenState();
}

class _RegisterDocumentScreenState extends State<RegisterDocumentScreen> {
  String? _fileName;
  bool _fileUploaded = false;

  void _onFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fileName = '${result.files.first.name} (${(result.files.first.size / 1024).toStringAsFixed(0)} kb)';
        _fileUploaded = true;
      });
    }
  }

  void _onFileRemove() {
    setState(() {
      _fileName = null;
      _fileUploaded = false;
    });
  }

  void _onNext(BuildContext context) {
    if (_fileUploaded) {
      context.go('/professional/register-confirm');
    }
  }

  void _onBack(BuildContext context) {
    context.go('/professional/register-contact');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => _onBack(context),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, color: Color(0xFF00553E)),
                            Text('Retour', style: GoogleFonts.poppins(color: Color(0xFF00553E))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Image.asset('assets/icons/logo.png', height: 50),
                          Text('agbaza', style: GoogleFonts.poppins(color: Color(0xFF00553E), fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Création de compte', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Document professionnel', style: GoogleFonts.poppins(fontSize: 16)),
                    const SizedBox(height: 20),
                    Text(
                      "Pour finaliser l'inscription, merci de nous faire parvenir un document (carte professionnelle/diplôme/...) justifiant de votre appartenance à la profession médicale.",
                      style: GoogleFonts.poppins(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: _onFileUpload,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.download, size: 32, color: Color(0xFF00553E)),
                            const SizedBox(height: 8),
                            Text('Importer un fichier (5 MB maximum)', style: GoogleFonts.poppins(fontSize: 14, color: Color(0xFF00553E))),
                          ],
                        ),
                      ),
                    ),
                    if (_fileUploaded && _fileName != null) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(_fileName!, style: GoogleFonts.poppins(fontSize: 14)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: _onFileRemove,
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _fileUploaded ? () => _onNext(context) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00553E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Suivant', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) => Container(
                        width: 40,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: i == 3 ? const Color(0xFF00553E) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/medic_homme.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
