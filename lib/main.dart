import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/repos/cart_repo.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/repos/cart_repo_impl.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/store_cubit/store_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Features/cart/presentation/manger/cart_cubit/cart_cubit.dart';
import 'Features/home/presentation/manger/category_cubit/category_cubit.dart';
import 'Features/home/presentation/manger/offer_cubit/offer_cubit.dart';
import 'Features/home/presentation/manger/product_cubit/product_cubit.dart';
import 'Features/splash/presentation/views/splash_view.dart';
import 'core/utils/theme_and_local/theme_and_local_cubit.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://hegfuluilgqgbcvtnymv.supabase.co",
    anonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhlZ2Z1bHVpbGdxZ2JjdnRueW12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5NjY4MTAsImV4cCI6MjA2OTU0MjgxMH0.1_zZ2sKOW0FKobr9V8FwAfq2kaqF6CdiQS42PU71HfM",
  );
  await Firebase.initializeApp(
  );
  FirebaseMessaging.instance.subscribeToTopic('all_users');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFDFDFD),
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          color: Color(0xFF1E1E1E),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      primaryTextTheme: const TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.lightBlue,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF2F4F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF6C757D),
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black87,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<OfferCubit>(
          create: (context) => OfferCubit(HomeRepoImpl())..getOffers(),
        ),
        BlocProvider<StoreCubit>(
          create: (context) => StoreCubit(HomeRepoImpl())..getStores(),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(HomeRepoImpl())..getProducts(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit(HomeRepoImpl())..getCategories(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(CartRepoImpl()),
        ),
        BlocProvider<ThemeAndLocalCubit>(
          create: (context) => ThemeAndLocalCubit()..loadPreferences(),
        ),
      ],
      child: BlocBuilder<ThemeAndLocalCubit, ThemeAndLocalState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale(state.locale),
          title: 'Flutter Demo',
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ar', ''),
          ],
          theme: lightTheme,
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xff100B29),
            primaryColor: const Color(0xff100B20),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff100B20),
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            colorScheme: const ColorScheme.dark(
              primary: Colors.blue,
              secondary: Colors.lightBlueAccent,
              surface: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
              onSurface: Colors.black,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleLarge: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Explicit color to avoid null
              ),
              bodyLarge: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: Colors.white,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            primaryTextTheme: const TextTheme(
              titleLarge: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Explicit color to avoid null
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xff1E1E2C),
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
              type: BottomNavigationBarType.fixed,
              elevation: 12,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xff1E1E2C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(
                color: Colors.white70,
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          home: const SplashView(),
        ),
      ),
    );
  }
}