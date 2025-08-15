import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../theme/app_theme.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
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
          title: Text(
            'Tableau de board',
            style: GoogleFonts.poppins(),
          ),
          onTap: () => context.go('/minister/dashboard'),
        ),
        ListTile(
          selected: true,
          selectedTileColor: const Color(0xFF00553E).withOpacity(0.1),
          title: Text(
            'Lancer un communiqué',
            style: GoogleFonts.poppins(
              color: const Color(0xFF00553E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        // Bouton déconnexion en bas
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            onTap: () {
              // Logique de déconnexion
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
                context.go('/minister/login', extra: 'logout_success');
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
          onPressed: () => context.go('/minister/dashboard'),
        ),
        IconButton(
          icon: const Icon(Icons.announcement),
          color: const Color(0xFF00553E),
          onPressed: () {},
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              context.go('/minister/login', extra: 'logout_success');
            },
          ),
        ),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  final bool isPreviewMode;
  final VoidCallback onPreviewToggle;
  final VoidCallback onShare;
  final TextEditingController titleController;
  final quill.QuillController controller;
  final FocusNode focusNode;

  const _MainContent({
    required this.isPreviewMode,
    required this.onPreviewToggle,
    required this.onShare,
    required this.titleController,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Header avec title et actions
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Row(
              children: [
                Text(
                  'Nouveau communiqué',
                  style: AppTheme.headingStyle,
                ),
                const Spacer(),
                // Toggle preview mode
                TextButton.icon(
                  onPressed: onPreviewToggle,
                  icon: Icon(
                    isPreviewMode ? Icons.edit : Icons.preview,
                    color: AppTheme.primaryColor,
                  ),
                  label: Text(
                    isPreviewMode ? 'Éditer' : 'Aperçu',
                    style: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Share button
                ElevatedButton.icon(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00553E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.share),
                  label: Text(
                    'Partager',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Contenu de l'éditeur
          Expanded(
            child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title field
                  TextField(
                    controller: titleController,
                    style: AppTheme.headingStyle,
                    decoration: InputDecoration(
                      hintText: 'Titre du communiqué',
                      hintStyle: AppTheme.headingStyle.copyWith(
                        color: Colors.grey[400],
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const Divider(height: 32),
                  if (!isPreviewMode) ...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                      child: quill.QuillToolbar.simple(
                        configurations: quill.QuillSimpleToolbarConfigurations(
                          controller: controller,
                          showAlignmentButtons: true,
                          showBackgroundColorButton: true,
                          showBoldButton: true,
                          showCenterAlignment: true,
                          showCodeBlock: true,
                          showColorButton: true,
                          showDirection: true,
                          showDividers: true,
                          showFontFamily: true,
                          showFontSize: true,
                          showIndent: true,
                          showItalicButton: true,
                          showJustifyAlignment: true,
                          showLeftAlignment: true,
                          showLink: true,
                          showListCheck: true,
                          showListBullets: true,
                          showListNumbers: true,
                          showQuote: true,
                          showRedo: true,
                          showRightAlignment: true,
                          showStrikeThrough: true,
                          showUnderLineButton: true,
                          showUndo: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: isPreviewMode
                            ? null
                            : Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: quill.QuillEditor.basic(
                        configurations: quill.QuillEditorConfigurations(
                          controller: controller,
                          enableInteractiveSelection: !isPreviewMode,
                          autoFocus: false,
                          expands: false,
                          padding: EdgeInsets.zero,
                          scrollable: true,
                          customStyles: quill.DefaultStyles(
                            h1: quill.DefaultTextBlockStyle(
                              GoogleFonts.poppins(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor,
                              ),
                              const quill.VerticalSpacing(16, 0),
                              const quill.VerticalSpacing(0, 0),
                              null,
                            ),
                            paragraph: quill.DefaultTextBlockStyle(
                              GoogleFonts.poppins(
                                fontSize: 16.0,
                                color: AppTheme.textColor,
                              ),
                              const quill.VerticalSpacing(0, 0),
                              const quill.VerticalSpacing(0, 0),
                              null,
                            ),
                          ),
                        ),
                      ),
                    ),
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

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPreviewMode = false;

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> showShareDialog(BuildContext context) async {
    bool toCitizens = true;
    bool toMedics = true;
    bool toMinistry = true;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text('Partager ce communiqué', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ce communiqué sera envoyé aux :', style: GoogleFonts.poppins()),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: toCitizens,
                  onChanged: (v) => setState(() => toCitizens = v!),
                  title: Text('Citoyens inscrits sur la plateforme', style: GoogleFonts.poppins()),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  value: toMedics,
                  onChanged: (v) => setState(() => toMedics = v!),
                  title: Text('Personnels medical', style: GoogleFonts.poppins()),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  value: toMinistry,
                  onChanged: (v) => setState(() => toMinistry = v!),
                  title: Text('Membres du ministère', style: GoogleFonts.poppins()),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Annuler', style: GoogleFonts.poppins(color: Colors.black87)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00553E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // TODO: Envoyer le communiqué selon les cases cochées
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Communiqué partagé avec succès',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: const Color(0xFF00553E),
                    ),
                  );
                },
                child: Text('Envoyer', style: GoogleFonts.poppins()),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleShare() {
    showShareDialog(context);
  }

  void _togglePreviewMode() {
    setState(() {
      _isPreviewMode = !_isPreviewMode;
    });
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
                    Container(
                      width: 250,
                      color: Colors.white,
                      child: _SidebarContent(),
                    ),
                    Expanded(
                      child: _MainContent(
                        isPreviewMode: _isPreviewMode,
                        onPreviewToggle: _togglePreviewMode,
                        onShare: _handleShare,
                        titleController: _titleController,
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                    ),
                  ],
                );
              } else if (isTablet) {
                return Row(
                  children: [
                    Container(
                      width: 80,
                      color: Colors.white,
                      child: _CompactSidebarContent(),
                    ),
                    Expanded(
                      child: _MainContent(
                        isPreviewMode: _isPreviewMode,
                        onPreviewToggle: _togglePreviewMode,
                        onShare: _handleShare,
                        titleController: _titleController,
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                    ),
                  ],
                );
              }
              // Mobile fallback (si besoin)
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'Nouveau communiqué',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _MainContent(
                      isPreviewMode: _isPreviewMode,
                      onPreviewToggle: _togglePreviewMode,
                      onShare: _handleShare,
                      titleController: _titleController,
                      controller: _controller,
                      focusNode: _focusNode,
                    ),
                  ),
                ],
              );
            },
          ),
          drawer: !isDesktop ? Drawer(child: _SidebarContent()) : null,
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