import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/models/cart_model/cart_model.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/presentation/manger/cart_cubit/cart_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/presentation/views/widgets/chick_out_success.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/presentation/views/widgets/chick_out_widget.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/home_view.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/show_message.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/custom_button.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/loading_widget.dart';
import 'package:multi_vendor_e_commerce_app/generated/l10n.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChickOutView extends StatefulWidget {
  final CartModel cart;
  final String name;
  final int payWay;
  final String phone;
  final String address;
  final double deliveryPrice;
  final String addressUrl;
  const ChickOutView({
    super.key,
    required this.cart,
    required this.name,
    required this.phone,
    required this.address,
    required this.deliveryPrice,
    required this.payWay,
    required this.addressUrl,
  });

  @override
  State<ChickOutView> createState() => _ChickOutViewState();
}

class _ChickOutViewState extends State<ChickOutView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PaymentData.initialize(
      apiKey:
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBMk5qWTVNQ3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5wNVdMZkV1NEx6TWJPVWVkRDVfY3AwQWtWelB4OXV4R1FYRk9SSldRTWxyLUk4T0pCdXFnWk5QQl9pWWFkQ2FpUWRkTVJNT29PamFxY250NjVPRU1pUQ==", // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: "947241", // Required: Found under Developers -> iframes
      integrationCardId:
          "5229376", // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          "5229377", // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // Optional User Data
      userData: UserData(
        email:
            Supabase.instance.client.auth.currentUser?.email ??
            '', // Optional: Defaults to 'NA'
        phone: widget.phone, // Optional: Defaults to 'NA'
        name: widget.name, // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: Colors.blue, // Default: Colors.blue
        scaffoldColor: Colors.white, // Default: Colors.white
        appBarBackgroundColor: Colors.blue, // Default: Colors.blue
        appBarForegroundColor: Colors.white, // Default: Colors.white
        textStyle: const TextStyle(), // Default: TextStyle()
        buttonStyle:
            ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
        circleProgressColor: Colors.blue, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).checkout)),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: (state is AddItemsToCartLoading ||state is AddItemsToCartError ),
          dismissible: (state is! AddItemsToCartLoading && state is! AddItemsToCartError),
          opacity: 0.4,
          // يعطي ظل خفيف وشيك
          progressIndicator: loadingWidget(context),

          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ChickOutWidget(
                  cart: widget.cart,
                  name: widget.name,
                  phone: widget.phone,
                  address: widget.address,
                  deliveryPrice: widget.deliveryPrice,
                  payWay: widget.payWay,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          onPressed: () async {
            if (widget.payWay == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentView(
                    onPaymentSuccess: () async {
                     String number =   await context.read<CartCubit>().addProductToCart(
                        cart: widget.cart,
                        name: widget.name,
                        phone: widget.phone,
                        address: widget.address,
                        isPaid: (widget.payWay == 1),
                        addressUrl: widget.addressUrl,
                        price: widget.deliveryPrice + widget.cart.total, context: context,
                      );

                      context.read<CartCubit>().clearCart(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ChickOutSuccess(number: number, date: DateTime.now().toUtc().toString(),)
                        ),
                        (route) => false, // يمنع أي رجوع
                      );
                    },

                    onPaymentError: () {
                      ShowMessage.showToast(
                        'حدث خطأ غير متوقع بالرجاء المحاولة لاحقاً...',
                      );
                    },
                    price:
                        (widget.deliveryPrice +
                        widget
                            .cart
                            .total), // Required: Total price (e.g., 100 for 100 EGP)
                  ),
                ),
              );
            } else {

             String number = await context.read<CartCubit>().addProductToCart(
                cart: widget.cart,
                name: widget.name,
                phone: widget.phone,
                address: widget.address,
                isPaid: (widget.payWay == 1),
                addressUrl: widget.addressUrl,
                price: widget.deliveryPrice + widget.cart.total, context: context,
              );
              context.read<CartCubit>().clearCart(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ChickOutSuccess(number: number, date: DateTime.now().toUtc().toString(),),
                ),
                (route) => false, // يمنع أي رجوع
              );
            }
          },
          text: 'تأكيد',
        ),
      ),
    );
  }
}
