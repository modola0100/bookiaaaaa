import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/creat_password.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/forget_password_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/otp_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/login/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/register/pages/register_screen.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookia/features/book_details/presentation/pages/book_details.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/pages/place_order.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/pages/details_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/main/pages/main_screen.dart';
import 'package:bookia/core/routes/routes_constants.dart';
import 'package:bookia/features/profile/pages/edit_profile.dart';
import 'package:bookia/features/profile/pages/my_order.dart';
import 'package:bookia/features/profile/pages/reset_password_screen.dart';
import 'package:bookia/features/profile/pages/faq_screen.dart';
import 'package:bookia/features/profile/pages/contact_us_screen.dart';
import 'package:bookia/features/profile/pages/privacy_terms_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome_screen/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String otp = '/otp';
  static const String creatPassword = '/creatPassword';
  static const String passwordChanged = '/passwordChanged';
  static const String home = '/home';
  static const String details = '/details';
  static const String mainscreen = '/mainscreen';
  static const String bookdetails = '/bookdetails';
  static const String placeOrder = '/placeOrder';
  static const String myOrder = '/myOrder';
  static const String editProfile = '/editProfile';
  static const String resetPassword = '/resetPassword';
  static const String faq = '/faq';
  static const String contactUs = '/contactUs';
  static const String privacyTerms = '/privacyTerms';

  static GoRouter route = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: myOrder, builder: (context, state) => const MyOrder()),
      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfile(),
      ),
      GoRoute(
        path: resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(path: faq, builder: (context, state) => const FAQScreen()),
      GoRoute(
        path: contactUs,
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: privacyTerms,
        builder: (context, state) => const PrivacyTermsScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: otp,
        builder: (context, state) {
          var email = state.extra as String;
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: OtpScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: creatPassword,
        builder: (context, state) {
          var otp = state.extra as int;
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: CreatPassword(otp: otp),
          );
        },
      ),
      GoRoute(
        path: passwordChanged,
        builder: (context, state) => const PasswordChangedScreen(),
      ),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: details,
        builder: (context, state) {
          final product = state.extra as Product;
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: DetailsScreen(book: product),
          );
        },
      ),
      GoRoute(
        path: mainscreen,
        builder: (context, state) => MainScreen(index: state.extra as int?),
      ),
      GoRoute(
        path: bookdetails,
        builder: (context, state) => BlocProvider(
          create: (context) => BookDetailsCubit()..getBookDetails(),
          child: const BookDetails(),
        ),
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) => BlocProvider(
          create: (context) => CartCubit()..refillData(),
          child: PlaceOrder(total: state.extra as String),
        ),
      ),
    ],
  );
}
