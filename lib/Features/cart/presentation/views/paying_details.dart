import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/models/cart_model/cart_model.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/presentation/views/chick_out.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/presentation/views/widgets/chick_out_widget.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/presentation/views/widgets/map_picker.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/show_message.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/custom_button.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/custom_text_field.dart';
import 'package:geolocator/geolocator.dart';

class PayingView extends StatefulWidget {
  final CartModel cart;
  const PayingView({super.key, required this.cart});

  @override
  State<PayingView> createState() => _PayingViewState();
}

bool enableAddressTextField = false;
String addressUrl = '';

class _PayingViewState extends State<PayingView> {
  final _formKey = GlobalKey<FormState>(); // 🌟 الخطوة الأولى

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  double deliveryPrice = 0;
  LatLng storeLocation = const LatLng(
    29.574217686990803,
    31.289961721105982,
  ); // موقع المطعم

  int _selectedPaymentMethod = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الشحن')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                // 🌟 لفيناها بفورم
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "تفاصيل المستخدم:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextFormField(
                      hintText: 'الاسم كامل',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'من فضلك أدخل الاسم كامل';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomTextFormField(
                      hintText: 'رقم الهاتف',
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'من فضلك أدخل رقم الهاتف';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: 'عنوان التوصيل',
                            controller: addressController,
                            readOnly: !enableAddressTextField,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'من فضلك أدخل عنوان التوصيل';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.mapMarkerAlt),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MapPickerScreen(),
                              ),
                            );

                            if (result is Map<String, dynamic>) {
                              addressController.text = result['address'] ?? '';
                              addressUrl = result['url'] ?? '';

                              // حساب المسافة
                              double distanceKm =
                                  Geolocator.distanceBetween(
                                    storeLocation.latitude,
                                    storeLocation.longitude,
                                    result['lat'],
                                    result['lng'],
                                  ) /
                                  1000;

                              // حساب الوزن الكلي في السلة
                              double totalWeight = widget.cart.items.fold(
                                0.0,
                                (sum, item) =>
                                    sum + (item.product.weight * item.quantity),
                              );

                              // سعر الشحن لكل كم لكل كجم
                              double costPerKmPerKg =
                                  20; // مثال: 5 جنيه لكل كم لكل كجم

                              // التكلفة = المسافة × الوزن الكلي × السعر لكل كم لكل كجم
                              double cost =
                                  distanceKm * totalWeight * costPerKmPerKg;
                              double minShippingCost = 40; // مثال 10 جنيه

                              if (cost < minShippingCost) {
                                cost = minShippingCost;
                              }
                              setState(() {
                                enableAddressTextField = false;
                                deliveryPrice = double.parse(
                                  cost.toStringAsFixed(2),
                                );
                              });

                              print(
                                "المسافة: ${distanceKm.toStringAsFixed(2)} كم",
                              );
                              print(
                                "إجمالي الوزن: ${totalWeight.toStringAsFixed(2)} كجم",
                              );
                              print("التكلفة: ${cost.toStringAsFixed(2)} جنيه");
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 32),
                    const Text(
                      "الدفع:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Card(
                      color: Theme.of(context).cardColor,
                      child: RadioListTile<int>(
                        title: Text(
                          "الدفع عند الاستلام",
                          style: AppStyles.semiBold18(context),
                        ),
                        value: 0,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),

                    Card(
                      color: Theme.of(context).cardColor,
                      child: const RadioListTile<int>(
                        title: Text("الدفع أونلاين"),
                        subtitle: Text(
                          "غير متاح حاليًا 🚫",
                          style: TextStyle(color: Colors.red),
                        ),
                        value: 1,
                        groupValue: 0,
                        onChanged: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChickOutView(
                    cart: widget.cart,
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    deliveryPrice: deliveryPrice,
                    payWay: _selectedPaymentMethod,
                    addressUrl: addressUrl,
                  ),
                ),
              );
            } else {
              // ❌ فيه حاجة ناقصة
              ShowMessage.showToast('من فضلك اكمل البيانات المطلوبة');
            }
          },
          text: "التالي",
        ),
      ),
    );
  }
}
