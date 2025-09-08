import 'package:flutter/material.dart';

import '../../../../../core/models/order_model.dart';
import '../../../../../core/utils/functions/is_arabic.dart';
import '../../../../../core/utils/styles/app_styles.dart';
import '../../../../../generated/l10n.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem item;

  const OrderItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final locale = S.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .surfaceVariant
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 60,
              height: 60,
              color: Theme
                  .of(context)
                  .colorScheme
                  .surface,
              child: product.imageUrl!.isNotEmpty
                  ? Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              )
                  : _buildPlaceholder(),
            ),
          ),
          const SizedBox(width: 16),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageHelper.isArabic()
                      ? product.arabicName
                      : product.englishName,
                  style: AppStyles.semiBold14(context).copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${locale.quantity}: ${item.quantity}',
                  style: AppStyles.regular12(context).copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.price.toStringAsFixed(2)} ${locale.currency}',
                  style: AppStyles.semiBold14(context).copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.shopping_bag_outlined,
        size: 24,
        color: Colors.grey.shade400,
      ),
    );
  }
}
