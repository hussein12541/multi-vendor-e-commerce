// import 'package:e_commerce_app/core/constant/constant.dart';
//
// import 'package:e_commerce_app/core/widgets/type_products_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// import '../../generated/l10n.dart';
// import '../logic/search/product_search_cubit.dart';
//
// class SearchWidget extends StatefulWidget {
//   const SearchWidget({
//     super.key,
//     required this.hintText,
//     required this.controller,
//     this.validator,
//     this.filterOnPressed,
//     this.orderOnPressed,
//     this.isFirst = true,
//   });
//
//   final VoidCallback? filterOnPressed;
//   final VoidCallback? orderOnPressed;
//   final String hintText;
//   final TextEditingController controller;
//
//   final String? Function(String?)? validator;
//
//   final bool isFirst;
//
//   @override
//   State<SearchWidget> createState() => _CustomTextFormFieldState();
// }
//
// class _CustomTextFormFieldState extends State<SearchWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x0A000000),
//             blurRadius: 9,
//             spreadRadius: 0,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         onSubmitted:
//             widget.isFirst
//                 ? (value) {
//                   widget.controller.clear();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => BlocProvider(
//                             create:
//                                 (context) =>
//                                     ProductSearchCubit()
//                                       ..getStandardProductData(
//                                         search_query: value,
//                                       ),
//                             child: BlocBuilder<
//                               ProductSearchCubit,
//                               ProductSearchState
//                             >(
//                               builder: (context, state) {
//                                 if (state is ProductSearchLoading||state is ProductSearchError) {
//                                   return Scaffold(
//                                     appBar: AppBar(
//                                       elevation: 0,
//                                       backgroundColor: Colors.transparent,
//                                       centerTitle: true,
//                                       automaticallyImplyLeading: true,
//                                       title: Text(S.of(context).search_results),
//                                     ),
//
//                                     body: const Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//
//                                   );
//                                 } else if (state is ProductSearchSuccess) {
//                                   if (state.products.isEmpty) {
//                                     return Scaffold(
//                                       appBar: AppBar(
//                                         elevation: 0,
//                                         backgroundColor: Colors.transparent,
//                                         centerTitle: true,
//                                         automaticallyImplyLeading: true,
//                                         title: Text(
//                                           S.of(context).search_results,
//                                         ),
//                                       ),
//
//                                       body: Center(
//                                         child: SvgPicture.asset(
//                                           'assets/image/images/search_unavilable.svg',
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                   return TypeProductsScreen(
//                                     searchWord: value,
//                                     products: state.products,
//                                     title: S.of(context).search_results,
//                                     onRefresh: () async {
//                                       await context
//                                           .read<ProductSearchCubit>()
//                                           .getStandardProductData(
//                                             search_query: value,
//                                           );
//                                     }, isHaveSearch: true,
//                                   );
//                                 }
//                                 return const SizedBox.shrink();
//                               },
//                             ),
//                           ),
//                     ),
//                   );
//                 }
//                 : (value) => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (context) => BlocProvider(
//                           create:
//                               (context) =>
//                                   ProductSearchCubit()..getStandardProductData(
//                                     search_query: value,
//                                   ),
//                           child: BlocBuilder<
//                             ProductSearchCubit,
//                             ProductSearchState
//                           >(
//                             builder: (context, state) {
//                               if (state is ProductSearchLoading||state is ProductSearchError) {
//                                 return Scaffold(
//                                   appBar: AppBar(
//                                     elevation: 0,
//                                     backgroundColor: Colors.transparent,
//                                     centerTitle: true,
//                                     automaticallyImplyLeading: true,
//                                     title: Text(S.of(context).search_results),
//                                   ),
//
//                                   body: const Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 );
//                               } else if (state is ProductSearchSuccess) {
//                                 if (state.products.isEmpty) {
//                                   return Scaffold(
//                                     appBar: AppBar(
//                                       elevation: 0,
//                                       backgroundColor: Colors.transparent,
//                                       centerTitle: true,
//                                       automaticallyImplyLeading: true,
//                                       title: Text(S.of(context).search_results),
//                                     ),
//
//                                     body: Center(
//                                       child: SvgPicture.asset(
//                                         'assets/image/images/search_unavilable.svg',
//                                       ),
//                                     ),
//                                   );
//                                 }
//
//                                 return TypeProductsScreen(
//                                   searchWord: value,
//                                   products: state.products,
//                                   title: S.of(context).search_results,
//                                   onRefresh: () async {
//                                     await context
//                                         .read<ProductSearchCubit>()
//                                         .getStandardProductData(
//                                           search_query: value,
//                                         );
//                                   }, isHaveSearch: true,
//                                 );
//                               }
//                               return const SizedBox.shrink();
//                             },
//                           ),
//                         ),
//                   ),
//                 ),
//         controller: widget.controller,
//         keyboardType: TextInputType.text,
//         decoration: InputDecoration(
//           hintText: widget.hintText,
//
//           prefixIcon: SizedBox(
//             height: 20.h,
//             width: 20.w,
//             child: Center(
//               child: SvgPicture.asset('assets/image/images/search.svg'),
//             ),
//           ),
//           suffixIcon:
//               (widget.filterOnPressed != null && widget.orderOnPressed != null)
//                   ? Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: widget.filterOnPressed,
//                         icon: SvgPicture.asset(
//                           'assets/image/images/fillter.svg',
//                           colorFilter: const ColorFilter.mode(
//                             Colors.grey,
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                       ),
//
//                       IconButton(
//                         icon: SvgPicture.asset(
//                           'assets/image/images/arrow-swap-horizontal.svg',
//                         ),
//
//                         onPressed: widget.orderOnPressed,
//                       ),
//                     ],
//                   )
//                   : null,
//           filled: true,
//           fillColor: Colors.white,
//           hintStyle: TextStyle(
//             fontSize: kFontSize13,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xff949D9E),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 12.w,
//             vertical: 14.h,
//           ),
//           border: const OutlineInputBorder(borderSide: BorderSide.none),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//           ),
//
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white, width: 1.2.w),
//           ),
//         ),
//       ),
//     );
//   }
// }
