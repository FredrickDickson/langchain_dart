import 'package:go_router/go_router.dart';
import 'package:arbibot/features/onboarding/screens/splash_screen.dart';
import 'package:arbibot/features/onboarding/screens/welcome_screen.dart';
import 'package:arbibot/features/auth/screens/login_screen.dart';
import 'package:arbibot/features/auth/screens/signup_screen.dart';
import 'package:arbibot/features/auth/screens/forgot_password_screen.dart';
import 'package:arbibot/features/shell/screens/shell_screen.dart';
import 'package:arbibot/features/home/screens/home_screen.dart';
import 'package:arbibot/features/settings/screens/settings_screen.dart';
import 'package:arbibot/features/profile/screens/profile_screen.dart';
import 'package:arbibot/features/chat/screens/chat_list_screen.dart';
import 'package:arbibot/features/chat/screens/chat_screen.dart';
import 'package:arbibot/features/documents/screens/documents_library_screen.dart';
import 'package:arbibot/features/documents/screens/document_viewer_screen.dart';
import 'package:arbibot/features/documents/screens/source_viewer_screen.dart';
import 'package:arbibot/features/research/screens/legal_research_screen.dart';
import 'package:arbibot/features/drafting/screens/draft_input_screen.dart';
import 'package:arbibot/features/drafting/screens/draft_preview_screen.dart';
import 'package:arbibot/features/profile/screens/cv_profile_screen.dart';
import 'package:arbibot/features/profile/screens/cv_builder_screen.dart';
import 'package:arbibot/features/profile/screens/cv_preview_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/chats',
          builder: (context, state) => const ChatListScreen(),
        ),
        GoRoute(
          path: '/library',
          builder: (context, state) => const DocumentsLibraryScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChatScreen(chatId: id);
      },
    ),
    GoRoute(
      path: '/document/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DocumentViewerScreen(documentId: id);
      },
    ),
    GoRoute(
      path: '/source/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return SourceViewerScreen(sourceId: id);
      },
    ),
    GoRoute(
      path: '/research',
      builder: (context, state) => const LegalResearchScreen(),
    ),
    GoRoute(
      path: '/draft/new',
      builder: (context, state) => const DraftInputScreen(),
    ),
    GoRoute(
      path: '/draft/preview',
      builder: (context, state) => const DraftPreviewScreen(),
    ),
    GoRoute(
      path: '/cv/profile',
      builder: (context, state) => const CVProfileScreen(),
    ),
    GoRoute(
      path: '/cv/builder',
      builder: (context, state) => const CVBuilderScreen(),
    ),
    GoRoute(
      path: '/cv/preview',
      builder: (context, state) => const CVPreviewScreen(),
    ),
  ],
);
