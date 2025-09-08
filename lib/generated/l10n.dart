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

  /// `About Us`
  String get about_us {
    return Intl.message('About Us', name: 'about_us', desc: '', args: []);
  }

  /// `Choose Language`
  String get choose_language {
    return Intl.message(
      'Choose Language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Contact Support`
  String get contact_support {
    return Intl.message(
      'Contact Support',
      name: 'contact_support',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error`
  String get unexpectedError {
    return Intl.message(
      'Unexpected Error',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully ✅`
  String get passwordChanged {
    return Intl.message(
      'Password changed successfully ✅',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Password change failed ❌`
  String get passwordChangeFailed {
    return Intl.message(
      'Password change failed ❌',
      name: 'passwordChangeFailed',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred: {error}`
  String errorOccurred(Object error) {
    return Intl.message(
      'An error occurred: $error',
      name: 'errorOccurred',
      desc: '',
      args: [error],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `At [Store Name], we believe that online shopping should be an enjoyable, easy, and secure experience. From the very beginning, our goal has been to build a comprehensive e-commerce platform that offers our customers high-quality products at affordable prices, with full transparency and reliability at every step of the purchasing process.\n\nOur aim is to be more than just a store – we see ourselves as partners in fulfilling our customers’ everyday needs and making their lives easier. Whether you’re looking for the latest products, the best deals, or outstanding after-sales service, we are here to deliver the quality and care you deserve.\n\nOur vision is to become the leading destination for online shopping in the Arab world, by focusing on innovation, customer satisfaction, and constantly expanding our product range. We believe that trust is built over time, which is why we are committed to providing an exceptional shopping experience that not only meets but exceeds your expectations.`
  String get about_us_content {
    return Intl.message(
      'At [Store Name], we believe that online shopping should be an enjoyable, easy, and secure experience. From the very beginning, our goal has been to build a comprehensive e-commerce platform that offers our customers high-quality products at affordable prices, with full transparency and reliability at every step of the purchasing process.\n\nOur aim is to be more than just a store – we see ourselves as partners in fulfilling our customers’ everyday needs and making their lives easier. Whether you’re looking for the latest products, the best deals, or outstanding after-sales service, we are here to deliver the quality and care you deserve.\n\nOur vision is to become the leading destination for online shopping in the Arab world, by focusing on innovation, customer satisfaction, and constantly expanding our product range. We believe that trust is built over time, which is why we are committed to providing an exceptional shopping experience that not only meets but exceeds your expectations.',
      name: 'about_us_content',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `User Details:`
  String get userDetails {
    return Intl.message(
      'User Details:',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone {
    return Intl.message('Phone Number', name: 'phone', desc: '', args: []);
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Payment:`
  String get payment {
    return Intl.message('Payment:', name: 'payment', desc: '', args: []);
  }

  /// `Cash on Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash on Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Pay Online`
  String get payOnline {
    return Intl.message('Pay Online', name: 'payOnline', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Please complete the required fields`
  String get pleaseFillData {
    return Intl.message(
      'Please complete the required fields',
      name: 'pleaseFillData',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get pleaseEnterFullName {
    return Intl.message(
      'Please enter your full name',
      name: 'pleaseEnterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get pleaseEnterPhone {
    return Intl.message(
      'Please enter your phone number',
      name: 'pleaseEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your delivery address`
  String get pleaseEnterAddress {
    return Intl.message(
      'Please enter your delivery address',
      name: 'pleaseEnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Loading location...`
  String get loading_location {
    return Intl.message(
      'Loading location...',
      name: 'loading_location',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch address`
  String get failed_to_fetch_address {
    return Intl.message(
      'Failed to fetch address',
      name: 'failed_to_fetch_address',
      desc: '',
      args: [],
    );
  }

  /// `Please wait for location to be determined`
  String get please_wait_for_location {
    return Intl.message(
      'Please wait for location to be determined',
      name: 'please_wait_for_location',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Location`
  String get confirm_location {
    return Intl.message(
      'Confirm Location',
      name: 'confirm_location',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get localeName {
    return Intl.message('en', name: 'localeName', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Delivery`
  String get delivery {
    return Intl.message('Delivery', name: 'delivery', desc: '', args: []);
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary:`
  String get order_summary {
    return Intl.message(
      'Order Summary:',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `No Stores Found`
  String get no_stores_found {
    return Intl.message(
      'No Stores Found',
      name: 'no_stores_found',
      desc: '',
      args: [],
    );
  }

  /// `No Products Found`
  String get no_products_found {
    return Intl.message(
      'No Products Found',
      name: 'no_products_found',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Search Results`
  String get searchResults {
    return Intl.message(
      'Search Results',
      name: 'searchResults',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message('Order', name: 'order', desc: '', args: []);
  }

  /// `Items`
  String get items {
    return Intl.message('Items', name: 'items', desc: '', args: []);
  }

  /// `More items`
  String get moreItems {
    return Intl.message('More items', name: 'moreItems', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);
  }

  /// `Shipped`
  String get shipped {
    return Intl.message('Shipped', name: 'shipped', desc: '', args: []);
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `No Orders Found`
  String get noOrders {
    return Intl.message(
      'No Orders Found',
      name: 'noOrders',
      desc: '',
      args: [],
    );
  }

  /// `No orders available`
  String get noOrdersSubtitle {
    return Intl.message(
      'No orders available',
      name: 'noOrdersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get orderDate {
    return Intl.message('Order Date', name: 'orderDate', desc: '', args: []);
  }

  /// `Track Order`
  String get trackOrder {
    return Intl.message('Track Order', name: 'trackOrder', desc: '', args: []);
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `The order is out for delivery, please contact support`
  String get orderOutForDelivery {
    return Intl.message(
      'The order is out for delivery, please contact support',
      name: 'orderOutForDelivery',
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
