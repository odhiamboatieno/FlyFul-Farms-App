import 'package:flyful_farms/features/auth/presentation/pages/login_page.dart';
import 'package:flyful_farms/features/auth/presentation/pages/register_page.dart';
import 'package:flyful_farms/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:flyful_farms/features/dashboard/presentation/pages/today_page.dart';
import 'package:flyful_farms/features/dashboard/presentation/pages/farm_page.dart';
import 'package:flyful_farms/features/jobs/presentation/pages/jobs_page.dart';
import 'package:flyful_farms/features/batches/presentation/pages/batch_list_page.dart';
import 'package:flyful_farms/features/batches/presentation/pages/batch_detail_page.dart';
import 'package:flyful_farms/features/batches/presentation/pages/create_batch_page.dart';
import 'package:flyful_farms/features/breeding/presentation/pages/cages_page.dart';
import 'package:flyful_farms/features/breeding/presentation/pages/cage_detail_page.dart';
import 'package:flyful_farms/features/breeding/presentation/pages/egg_collection_page.dart';
import 'package:flyful_farms/features/breeding/presentation/pages/egg_quality_page.dart';
import 'package:flyful_farms/features/breeding/presentation/pages/maintenance_page.dart';
import 'package:flyful_farms/features/feeding/presentation/pages/feed_type_page.dart';
import 'package:flyful_farms/features/feeding/presentation/pages/feed_quantity_page.dart';
import 'package:flyful_farms/features/feeding/presentation/pages/feed_photo_page.dart';
import 'package:flyful_farms/features/harvest/presentation/pages/harvest_page.dart';
import 'package:flyful_farms/features/harvest/presentation/pages/harvest_larvae_page.dart';
import 'package:flyful_farms/features/harvest/presentation/pages/harvest_frass_page.dart';
import 'package:flyful_farms/features/harvest/presentation/pages/harvest_pupa_page.dart';
import 'package:flyful_farms/features/inventory/presentation/pages/inventory_page.dart';
import 'package:flyful_farms/features/reports/presentation/pages/reports_page.dart';
import 'package:flyful_farms/features/reports/presentation/pages/compare_page.dart';
import 'package:flyful_farms/features/reports/presentation/pages/stock_page.dart';
import 'package:flyful_farms/features/profile/presentation/pages/profile_page.dart';
import 'package:flyful_farms/features/profile/presentation/pages/settings_page.dart';
import 'package:flyful_farms/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flyful_farms/features/profile/presentation/pages/sync_page.dart';
import 'package:flyful_farms/features/record/presentation/pages/record_page.dart';
import 'package:flyful_farms/features/success/presentation/pages/success_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/today',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const TodayPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
      GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordPage()),
      GoRoute(path: '/today', builder: (context, state) => const TodayPage()),
      GoRoute(path: '/jobs', builder: (context, state) => const JobsPage()),
      GoRoute(path: '/batches', builder: (context, state) => const BatchListPage()),
      GoRoute(path: '/batches/:id', builder: (context, state) => BatchDetailPage(id: state.pathParameters['id']!)),
      GoRoute(path: '/batches/new', builder: (context, state) => const CreateBatchPage()),
      GoRoute(path: '/cages', builder: (context, state) => const CagesPage()),
      GoRoute(path: '/cages/:id', builder: (context, state) => const CageDetailPage()),
      GoRoute(path: '/eggs', builder: (context, state) => const EggCollectionPage()),
      GoRoute(path: '/egg-quality', builder: (context, state) => const EggQualityPage()),
      GoRoute(path: '/maintenance', builder: (context, state) => const MaintenancePage()),
      GoRoute(path: '/feed-type', builder: (context, state) => const FeedTypePage()),
      GoRoute(path: '/feed', builder: (context, state) => const FeedQuantityPage()),
      GoRoute(path: '/feed-photo', builder: (context, state) => const FeedPhotoPage()),
      GoRoute(path: '/harvest', builder: (context, state) => const HarvestPage()),
      GoRoute(path: '/harvest-larvae', builder: (context, state) => const HarvestLarvaePage()),
      GoRoute(path: '/harvest-frass', builder: (context, state) => const HarvestFrassPage()),
      GoRoute(path: '/harvest-pupa', builder: (context, state) => const HarvestPupaPage()),
      GoRoute(path: '/inventory', builder: (context, state) => const InventoryPage()),
      GoRoute(path: '/reports', builder: (context, state) => const ReportsPage()),
      GoRoute(path: '/stock', builder: (context, state) => const StockPage()),
      GoRoute(path: '/compare', builder: (context, state) => const ComparePage()),
      GoRoute(path: '/farm', builder: (context, state) => const FarmPage()),
      GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
      GoRoute(path: '/edit-profile', builder: (context, state) => const EditProfilePage()),
      GoRoute(path: '/sync', builder: (context, state) => const SyncPage()),
      GoRoute(path: '/record', builder: (context, state) => const RecordPage()),
      GoRoute(path: '/success', builder: (context, state) => const SuccessPage()),
    ],
  );
}
