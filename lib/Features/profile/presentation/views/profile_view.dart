import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/is_arabic.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/theme_and_local/theme_and_local_cubit.dart';
import 'package:multi_vendor_e_commerce_app/generated/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/functions/show_message.dart';
import '../../../../core/utils/local_storage_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../home/presentation/views/widgets/bottom_nav_height.dart';
import '../../../my_orders/presentation/view/order_screen.dart';
import '../widgets/about_us.dart';
import '../widgets/change_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _changeLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Directionality(
            textDirection: LanguageHelper.isArabic()
                ? TextDirection.rtl
                : TextDirection.ltr,
            // العنوان يمين
            child: Text(S.of(context).choose_language),
          ),
          content: Directionality(
            textDirection: LanguageHelper.isArabic()
                ? TextDirection.ltr
                : TextDirection.rtl,
            // المحتوى يسار
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title:  Text('العربية',style: AppStyles.semiBold16(context),),
                  onTap: () async {
                    Navigator.pop(context);

                    await context.read<ThemeAndLocalCubit>().changeLanguage('ar');
                  },
                ),
                ListTile(
                  title:  Text('English',style: AppStyles.semiBold16(context)),
                  onTap: () async {
                    Navigator.pop(context);
                    await context.read<ThemeAndLocalCubit>().changeLanguage('en');

                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? name = "";

  Future<void> _loadUserName() async {
    name = await LocalStorageHelper.getUserName();
    setState(() {}); // علشان تحدث الـ UI بعد ما الاسم يرجع
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 65),
          Center(
            child: Column(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 60)),
                const SizedBox(height: 8),

                Text(
                  name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  Supabase.instance.client.auth.currentUser!.email ?? "",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            S.of(context).general,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // _buildMenuItem(
          //   title: S.of(context).my_account,
          //   icon: Icons.person_outline,
          //   onTap: () {
          //     // TODO: انتقل للملف الشخصي
          //   },
          // ),
          _buildMenuItem(
            isSvg: true,
            title: S.of(context).myOrders,
            icon: Icons.inventory_2_outlined,
            imagePath: Assets.imagesBox,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderScreen()),
              );
            },
            context: context,
          ),

          // _buildSwitchItem(title: 'الإشعارات', icon: Icons.notifications),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              S.of(context).language,
              style: AppStyles.semiBold14(
                context,
              ).copyWith(color: Color(0xff949D9E)),
            ),
            trailing: Text(
              LanguageHelper.isArabic() ? 'العربية' : "English",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () => _changeLanguage(context),
          ),
          BlocBuilder<ThemeAndLocalCubit, ThemeAndLocalState>(
            builder: (context, state) {
              return _buildSwitchItem(
                title: S.of(context).dark_mode,
                icon: Icons.dark_mode,
                value: state.isDark, // هنا بحدد القيمة من الكيوبت
                onChanged: (bool newValue) async {
                  await context.read<ThemeAndLocalCubit>().toggleTheme();
                },
              );
            },
          ),
          // _buildSwitchItem(title: 'الوضع', icon: Icons.color_lens),
          const SizedBox(height: 24),
          Text(
            S.of(context).help,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          _buildMenuItem(
            title: S.of(context).changePassword,
            icon: Icons.password_sharp,
            isSvg: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
            context: context,
          ),
          _buildMenuItem(
            title: S.of(context).contact_support,
            icon: Icons.support_agent_outlined,
            onTap: () async {
              final Uri whatsappUrl = Uri.parse('https://wa.me/201153743537');

              try {
                final canLaunch = await canLaunchUrl(whatsappUrl);
                if (!canLaunch) {
                  throw 'الرابط مش مدعوم على الجهاز 😢';
                }

                final launched = await launchUrl(
                  whatsappUrl,
                  mode: LaunchMode.externalApplication,
                );

                if (!launched) {
                  throw 'فشل في فتح واتساب 😞';
                }
              } catch (e) {
                debugPrint('🚨 خطأ أثناء محاولة فتح واتساب: $e');
                ShowMessage.showToast(S.of(context).unexpectedError);
              }
            },
            context: context,
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            title: S.of(context).about_us,
            icon: Icons.info_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
            context: context,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.secondary.withOpacity(0.1),
              foregroundColor: Theme.of(context).colorScheme.secondary,
              minimumSize: const Size.fromHeight(48),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              await LocalStorageHelper.clearUserName();
              final prefs = await SharedPreferences.getInstance();
              final String? langCode = prefs.getString('language_code');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(
                    // initialLocale:
                    //     langCode != null
                    //         ? Locale(langCode)
                    //         : const Locale('ar'),
                  ),
                ),
                (route) => false,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).logout),
                SizedBox(width: 18), // المسافة بين النص والأيقونة
                LanguageHelper.isArabic()
                    ? SvgPicture.asset(
                        color: Theme.of(context).colorScheme.secondary,
                        Assets.imagesLogout,
                        height: 18,
                        width: 18,
                      )
                    : const Icon(Icons.logout),
              ],
            ),
          ),
          const SizedBox(height: 35 + kBottomNavigationBarHeight),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    String imagePath = "",
    bool isSvg = false,
    required IconData icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      leading: isSvg
          ? SvgPicture.asset(
              imagePath,
              width: 20,
              height: 20,
              color: Theme.of(context).colorScheme.secondary,
            )
          : Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(
        title,
        style: AppStyles.semiBold16(context).copyWith(color: Color(0xff949D9E)),
      ),
      trailing:  Icon(Icons.arrow_forward_ios, size: 16,color: Theme.of(context).colorScheme.secondary,),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required IconData icon,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title,   style: AppStyles.semiBold16(context).copyWith(color: Color(0xff949D9E)),),
      value: value,
      onChanged: onChanged,
    );
  }
}
