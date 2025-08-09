// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All you need... in one place!`
  String get splashWord {
    return Intl.message(
      'All you need... in one place!',
      name: 'splashWord',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter your email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Login with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `please Enter Your Name`
  String get pleaseEnterYourName {
    return Intl.message(
      'please Enter Your Name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Don't worry, just type in your email and we'll send the verification code.`
  String get forget_password_content {
    return Intl.message(
      'Don\'t worry, just type in your email and we\'ll send the verification code.',
      name: 'forget_password_content',
      desc: '',
      args: [],
    );
  }

  /// `The operation was successful, check your mail if it don't exist chick spam....`
  String get sendOTP {
    return Intl.message(
      'The operation was successful, check your mail if it don\'t exist chick spam....',
      name: 'sendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email...`
  String get sendOTP_error {
    return Intl.message(
      'Invalid email...',
      name: 'sendOTP_error',
      desc: '',
      args: [],
    );
  }

  /// `forget password`
  String get forget_password_title {
    return Intl.message(
      'forget password',
      name: 'forget_password_title',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Favorite`
  String get favorites {
    return Intl.message('Favorite', name: 'favorites', desc: '', args: []);
  }

  /// `OFF`
  String get discount {
    return Intl.message('OFF', name: 'discount', desc: '', args: []);
  }

  /// `Not Available`
  String get notAvailable {
    return Intl.message(
      'Not Available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `More...`
  String get more {
    return Intl.message('More...', name: 'more', desc: '', args: []);
  }

  /// `Best Seller`
  String get bestSeller {
    return Intl.message('Best Seller', name: 'bestSeller', desc: '', args: []);
  }

  /// `Latest`
  String get latest {
    return Intl.message('Latest', name: 'latest', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Search for a product or store`
  String get searchProductOrStore {
    return Intl.message(
      'Search for a product or store',
      name: 'searchProductOrStore',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Stores`
  String get stores {
    return Intl.message('Stores', name: 'stores', desc: '', args: []);
  }

  /// `Search category`
  String get searchCategory {
    return Intl.message(
      'Search category',
      name: 'searchCategory',
      desc: '',
      args: [],
    );
  }

  /// `Search store`
  String get searchStore {
    return Intl.message(
      'Search store',
      name: 'searchStore',
      desc: '',
      args: [],
    );
  }

  /// `Search product`
  String get searchProduct {
    return Intl.message(
      'Search product',
      name: 'searchProduct',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message('Sort by', name: 'sortBy', desc: '', args: []);
  }

  /// `Price: Low to High`
  String get priceLowToHigh {
    return Intl.message(
      'Price: Low to High',
      name: 'priceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `Price: High to Low`
  String get priceHighToLow {
    return Intl.message(
      'Price: High to Low',
      name: 'priceHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `Alphabet: A-Z`
  String get alphabetAZ {
    return Intl.message(
      'Alphabet: A-Z',
      name: 'alphabetAZ',
      desc: '',
      args: [],
    );
  }

  /// `Alphabet: Z-A`
  String get alphabetZA {
    return Intl.message(
      'Alphabet: Z-A',
      name: 'alphabetZA',
      desc: '',
      args: [],
    );
  }

  /// `Filter by price`
  String get filterByPrice {
    return Intl.message(
      'Filter by price',
      name: 'filterByPrice',
      desc: '',
      args: [],
    );
  }

  /// `Highest price`
  String get sortByHighestPrice {
    return Intl.message(
      'Highest price',
      name: 'sortByHighestPrice',
      desc: '',
      args: [],
    );
  }

  /// `Lowest price`
  String get sortByLowestPrice {
    return Intl.message(
      'Lowest price',
      name: 'sortByLowestPrice',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical`
  String get sortByAlphabetical {
    return Intl.message(
      'Alphabetical',
      name: 'sortByAlphabetical',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Alphabetical`
  String get alphabetical {
    return Intl.message(
      'Alphabetical',
      name: 'alphabetical',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `From`
  String get availableFrom {
    return Intl.message('From', name: 'availableFrom', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Enter starting price`
  String get enterStartPrice {
    return Intl.message(
      'Enter starting price',
      name: 'enterStartPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter ending price`
  String get enterEndPrice {
    return Intl.message(
      'Enter ending price',
      name: 'enterEndPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid price range`
  String get enterValidPrice {
    return Intl.message(
      'Please enter a valid price range',
      name: 'enterValidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Welcome !...`
  String get greeting {
    return Intl.message('Welcome !...', name: 'greeting', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Average`
  String get average {
    return Intl.message('Average', name: 'average', desc: '', args: []);
  }

  /// `Your Rating`
  String get yourRating {
    return Intl.message('Your Rating', name: 'yourRating', desc: '', args: []);
  }

  /// `Rate This Store`
  String get rateThisStore {
    return Intl.message(
      'Rate This Store',
      name: 'rateThisStore',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Added to cart successfully!`
  String get addedToCartSuccessfully {
    return Intl.message(
      'Added to cart successfully!',
      name: 'addedToCartSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Quantity increased`
  String get quantityIncreased {
    return Intl.message(
      'Quantity increased',
      name: 'quantityIncreased',
      desc: '',
      args: [],
    );
  }

  /// `Max quantity reached`
  String get maxQuantityReached {
    return Intl.message(
      'Max quantity reached',
      name: 'maxQuantityReached',
      desc: '',
      args: [],
    );
  }

  /// `Quantity decreased`
  String get quantityDecreased {
    return Intl.message(
      'Quantity decreased',
      name: 'quantityDecreased',
      desc: '',
      args: [],
    );
  }

  /// `Item removed`
  String get itemRemoved {
    return Intl.message(
      'Item removed',
      name: 'itemRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Cart cleared`
  String get cartCleared {
    return Intl.message(
      'Cart cleared',
      name: 'cartCleared',
      desc: '',
      args: [],
    );
  }

  /// `L.E`
  String get currency {
    return Intl.message('L.E', name: 'currency', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Your cart is empty`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Add items to your cart to get started`
  String get addItemsToCart {
    return Intl.message(
      'Add items to your cart to get started',
      name: 'addItemsToCart',
      desc: '',
      args: [],
    );
  }

  /// `Total Items`
  String get totalItems {
    return Intl.message('Total Items', name: 'totalItems', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message('Clear Cart', name: 'clearCart', desc: '', args: []);
  }

  /// `Are you sure you want to clear your cart?`
  String get clearCartConfirmation {
    return Intl.message(
      'Are you sure you want to clear your cart?',
      name: 'clearCartConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Product not found!`
  String get productNotFound {
    return Intl.message(
      'Product not found!',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Available quantity of`
  String get availableQuantityFrom {
    return Intl.message(
      'Available quantity of',
      name: 'availableQuantityFrom',
      desc: '',
      args: [],
    );
  }

  /// `is`
  String get quantityIs {
    return Intl.message('is', name: 'quantityIs', desc: '', args: []);
  }

  /// `Search for a location`
  String get search_for_location {
    return Intl.message(
      'Search for a location',
      name: 'search_for_location',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
