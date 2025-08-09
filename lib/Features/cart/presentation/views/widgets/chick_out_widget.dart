import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/models/cart_model/cart_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/generated/l10n.dart';

class ChickOutWidget extends StatelessWidget {
  final CartModel cart;
  final String name;
  final String phone;
  final String address;
  final double deliveryPrice;
  final int payWay;
  const ChickOutWidget({
    super.key,
    required this.cart,
    required this.name,
    required this.phone,
    required this.address,
    required this.deliveryPrice, required this.payWay,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('ملخص الطلب:', style: AppStyles.bold24(context)),
              ],
            ),
            const SizedBox(height: 8),
            Card(
              color: Theme.of(context).cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    GestureDetector(
                      onTap:() =>  Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Icon(FontAwesomeIcons.edit,size: 14, color: Theme.of(context).colorScheme.secondary,),
                        const SizedBox(width: 8),
                         Text('تعديل',style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),)
                      ],),
                    ),
                       const SizedBox(height: 12),
                    // Name field
                    _buildInfoTile(
                      icon: Icons.person,
                      title: 'الاسم',
                      value: name,
                    ),
            
                       const SizedBox(height: 12),
                    // Name field
                    _buildInfoTile(
                      icon: Icons.phone,
                      title: 'رقم الهاتف',
                      value: phone,
                    ),
            
                    const SizedBox(height: 12),
                    _buildInfoTile(
                      icon: FontAwesomeIcons.locationDot,
                      title: 'العنوان',
                      value: address,
                    ),
            
                    const SizedBox(height: 12),
            
                    // Subtotal
                    _buildInfoTile(
                      icon: FontAwesomeIcons.dollarSign,
                      title: 'المجموع الفرعي',
                      value:
                          '${cart.total.toString()} ${S.of(context).currency}',
                    ),
            
                    const SizedBox(height: 12),
            
                    // Delivery
                    _buildInfoTile(
                      icon: Icons.delivery_dining,
                      title: 'التوصيل',
                      value:
                          '${deliveryPrice.toString()} ${S.of(context).currency}',
                    ),
            
            
                    const SizedBox(height: 12),
            
                    // Delivery
                    _buildInfoTile(
                      icon: Icons.payment,
                      title: 'طريقة الدفع',
                      value:payWay == 1? 'الدفع أونلاين' :
                          'الدفع عند الاستلام',
                    ),
            
                    const Divider(height: 32, thickness: 1.2),
            
                    // Total - Highlighted
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FontAwesomeIcons.coins,
                          color: Colors.amber.shade800,
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'المجموع الكلي',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        '${(deliveryPrice + cart.total).toString()} ${S.of(context).currency}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  // Reusable tile widget
 Widget _buildInfoTile({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Text(
          value,
                  overflow: TextOverflow.ellipsis,
        
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}

}
