import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/local_storage_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../generated/l10n.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await LocalStorageHelper.getUserName();
    setState(() {
      userName = name ?? Supabase.instance.client.auth.currentUser?.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(FontAwesomeIcons.solidUser)),
      title: Text(S.of(context).greeting, style: AppStyles.regular16(context)),
      subtitle: Text(userName ?? S.of(context).loading, style: AppStyles.medium18(context)),
      trailing: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE3F2FD),
            child: Icon(
              FontAwesomeIcons.bell,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // 🔴 النقطة الحمراء
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
