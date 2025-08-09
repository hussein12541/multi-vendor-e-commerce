import '../../../models/product_model.dart';
import '../../functions/is_arabic.dart';

class ProductFilterHelper {
  // فلترة حسب الاسم أو الوصف
  static List<ProductModel> filterBySearch(List<ProductModel> products, String query) {
    final lowerQuery = query.toLowerCase();

    return products.where((product) {
      if (LanguageHelper.isArabic()) {
        return product.arabicName.toLowerCase().contains(lowerQuery) ||
            product.arabicDescription.toLowerCase().contains(lowerQuery);
      } else {
        return product.englishName.toLowerCase().contains(lowerQuery) ||
            product.englishDescription.toLowerCase().contains(lowerQuery);
      }
    }).toList();
  }

  // ترتيب حسب السعر تصاعدي
  static List<ProductModel> sortByPriceLowToHigh(List<ProductModel> products) {
    final copy = List<ProductModel>.from(products);
    copy.sort((a, b) => a.price.compareTo(b.price));
    return copy;
  }

  // ترتيب حسب السعر تنازلي
  static List<ProductModel> sortByPriceHighToLow(List<ProductModel> products) {
    final copy = List<ProductModel>.from(products);
    copy.sort((a, b) => b.price.compareTo(a.price));
    return copy;
  }

  // ترتيب أبجديًا حسب اللغة الحالية
  static List<ProductModel> sortByAlphabetical(List<ProductModel> products) {
    final copy = List<ProductModel>.from(products);
    if (LanguageHelper.isArabic()) {
      copy.sort((a, b) => a.arabicName.compareTo(b.arabicName));
    } else {
      copy.sort((a, b) => a.englishName.compareTo(b.englishName));
    }
    return copy;
  }

  // ترتيب أبجديًا بالعكس حسب اللغة الحالية
  static List<ProductModel> sortByAlphabeticalReverse(List<ProductModel> products) {
    final copy = List<ProductModel>.from(products);
    if (LanguageHelper.isArabic()) {
      copy.sort((a, b) => b.arabicName.compareTo(a.arabicName));
    } else {
      copy.sort((a, b) => b.englishName.compareTo(a.englishName));
    }
    return copy;
  }

  // فلترة حسب نطاق سعر معين
  static List<ProductModel> filterByPriceRange(List<ProductModel> products, double from, double to) {
    return products.where((product) {
      final price = product.price;
      return price >= from && price <= to;
    }).toList();
  }
}
