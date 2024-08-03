import 'package:go_router/go_router.dart';
import 'package:shopy/features/layout/presentation/views/profile/widget/change_password.dart';
import '../../../features/auth/presentation/views/login_view.dart';
import '../../../features/auth/presentation/views/register_view.dart';
import '../../../features/layout/presentation/views/layout_view.dart';
import '../../../features/layout/presentation/views/profile/widget/update_user_data.dart';
import '../../../features/onboarding/presetation/view/on_boading_view.dart';
import '../../../features/search/presentation/view/search_view.dart';
import '../../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kLayoutView = '/layoutView';
  static const kOnBoardingView = '/onBoardingView';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kUpdateUser = '/updateuser';
  static const kChangepassword = '/changepassword';
  static const ksearch = '/search';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/', // initial route
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLayoutView,
        builder: (context, state) => const LayoutView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LogInView(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: kUpdateUser,
        builder: (context, state) => UpdateUserDataView(),
      ),
      GoRoute(
        path: kChangepassword,
        builder: (context, state) => ChangePasswordView(),
      ),
      GoRoute(
        path: ksearch,
        builder: (context, state) => const SearchView(),
      ),
    ],
  );
}
