import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/screens/role_selection_screen.dart';
import 'package:frontend/screens/minister/login_minister_screen.dart';
import 'package:frontend/screens/minister/dashboard_minister_screen.dart';
import 'package:frontend/screens/minister/announcement_screen.dart';
import 'package:frontend/screens/professional/login_professional_screen.dart';
import 'package:frontend/screens/professional/forgot_password_screen.dart';
import 'package:frontend/screens/professional/verify_code_screen.dart';
import 'package:frontend/screens/professional/reset_password_screen.dart';
import 'package:frontend/screens/professional/dashboard_screen.dart';
import 'package:frontend/screens/professional/register_professional_screen.dart';
import 'package:frontend/screens/professional/register_contact_screen.dart';
import 'package:frontend/screens/professional/register_document_screen.dart';
import 'package:frontend/screens/professional/register_confirm_screen.dart';
import 'package:frontend/screens/professional/register_password_screen.dart';
import 'package:frontend/screens/professional/patient_management_screen.dart';
import 'package:frontend/screens/professional/patient_detail_screen.dart';
import 'package:frontend/screens/professional/add_patient_screen.dart';
import 'package:frontend/screens/professional/recap_patient_screen.dart';
import 'package:frontend/screens/professional/consultation_history_screen.dart';
import 'package:frontend/screens/hospital/hospital_register_documents_screen.dart';
import 'package:frontend/screens/hospital/hospital_register_login_screen.dart';
import 'package:frontend/screens/hospital/hospital_register_info_screen.dart';
import 'package:frontend/screens/hospital/hospital_register_additional_info_screen.dart';
import 'package:frontend/screens/hospital/hospital_register_security_screen.dart';
import 'package:frontend/screens/hospital/hospital_register_success_screen.dart';
import 'package:frontend/screens/hospital/hospital_dashboard_screen.dart';
import 'package:frontend/screens/hospital/beds_management_screen.dart';
import 'package:frontend/screens/hospital/blood_management_screen.dart';
import 'package:frontend/screens/hospital/products_management_screen.dart';
import 'package:frontend/screens/hospital/hospital_map_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RoleSelectionScreen(),
    ), 
    GoRoute(
      path: '/minister/login',
      builder: (context, state) => const LoginMinisterScreen(),
    ),
    GoRoute(
      path: '/minister/dashboard',
      builder: (context, state) => const DashboardMinisterScreen(),
    ),
    GoRoute(
      path: '/minister/announcement',
      builder: (context, state) => const AnnouncementScreen(),
    ),
    GoRoute(
      path: '/professional/login',
      builder: (context, state) => const LoginProfessionalScreen(),
    ),
    GoRoute(
      path: '/professional/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/professional/verify-code',
      builder: (context, state) => const VerifyCodeScreen(),
    ),
    GoRoute(
      path: '/professional/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: '/professional/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/professional/register',
      builder: (context, state) => const RegisterProfessionalScreen(),
    ),
    GoRoute(
      path: '/professional/register-password',
      builder: (context, state) => const RegisterPasswordScreen(),
    ),
    GoRoute(
      path: '/professional/register-contact',
      builder: (context, state) => const RegisterContactScreen(),
    ),
    GoRoute(
      path: '/professional/register-confirm',
      builder: (context, state) => const RegisterConfirmScreen(),
    ),
    GoRoute(
      path: '/professional/register-document',
      builder: (context, state) => const RegisterDocumentScreen(),
    ),
    GoRoute(
      path: '/professional/management',
      builder: (context, state) => const PatientManagementScreen(),
    ),
    GoRoute(
      path: '/professional/add-patient',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return AddPatientScreen(
          initialData: data?['patientData'] as Map<String, String>?,
          initialStep: data?['step'] as int?,
        );
      },
    ),
    GoRoute(
      path: '/professional/recap-patient',
      builder: (context, state) {
        final patientData = state.extra as Map<String, String>? ?? {};
        return RecapPatientScreen(patientData: patientData);
      },
    ),
    GoRoute(
      path: '/professional/patient-detail',
      builder: (context, state) {
        final patient = state.extra as Map<String, String>? ?? {
          'nip': '20038988781890',
          'nom': 'AGOLI-AGBO',
          'prenom': 'Espoir',
          'email': 'espoiragoliagbo@gmail.com',
          'date': '27/07/2025',
          'phone': '+229 66521324',
          'profession': 'Développeur',
          'address': 'Cotonou, Bénin',
          'height': '156',
          'weight': '63',
          'blood_group': 'O+',
          'electrophoresis': 'AA',
          'allergies': 'Arachides, Lactose, Glutten',
          'vaccinations': 'Polio, Fievre jaune, COVID-19, Méningite',
        };
        return PatientDetailScreen(patient: patient);
      },
    ),
    GoRoute(
      path: '/professional/consultation-history',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>? ?? {};
        final patient = data['patient'] as Map<String, String>? ?? {
          'nip': '20038988781890',
          'nom': 'AGOLI-AGBO',
          'prenom': 'Espoir',
          'email': 'espoiragoliagbo@gmail.com',
          'date': '27/07/2025',
          'phone': '+229 66521324',
          'profession': 'Développeur',
          'address': 'Cotonou, Bénin',
          'height': '156',
          'weight': '63',
          'blood_group': 'O+',
          'electrophoresis': 'AA',
          'allergies': 'Arachides, Lactose, Glutten',
          'vaccinations': 'Polio, Fievre jaune, COVID-19, Méningite',
        };
        final consultation = data['consultation'] as Map<String, dynamic>? ?? {
          'date': '27 Juin 2025',
          'doctor': 'Dr GAHITO Nukonklu',
          'type': 'Consultation générale',
        };
        return ConsultationHistoryScreen(
          patient: patient,
          consultation: consultation,
        );
      },
    ),
    // Routes pour l'inscription des hôpitaux
    GoRoute(
      path: '/hospital/register-documents',
      builder: (context, state) => const HospitalRegisterDocumentsScreen(),
    ),
    GoRoute(
      path: '/hospital/register-login',
      builder: (context, state) => const HospitalRegisterLoginScreen(),
    ),
    GoRoute(
      path: '/hospital/register-info',
      builder: (context, state) => const HospitalRegisterInfoScreen(),
    ),
    GoRoute(
      path: '/hospital/register-additional-info',
      builder: (context, state) => const HospitalRegisterAdditionalInfoScreen(),
    ),
    GoRoute(
      path: '/hospital/register-security',
      builder: (context, state) => const HospitalRegisterSecurityScreen(),
    ),
    GoRoute(
      path: '/hospital/register-success',
      builder: (context, state) => const HospitalRegisterSuccessScreen(),
    ),
    GoRoute(
      path: '/hospital/dashboard',
      builder: (context, state) => const HospitalDashboardScreen(),
    ),
    GoRoute(
      path: '/hospital/beds-management',
      builder: (context, state) => const BedsManagementScreen(),
    ),
    GoRoute(
      path: '/hospital/blood-management',
      builder: (context, state) => const BloodManagementScreen(),
    ),
    GoRoute(
      path: '/hospital/products-management',
      builder: (context, state) => const ProductsManagementScreen(),
    ),
    GoRoute(
      path: '/hospital/map',
      builder: (context, state) => const HospitalMapScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page non trouvée: ${state.error}'),
    ),
  ),
);