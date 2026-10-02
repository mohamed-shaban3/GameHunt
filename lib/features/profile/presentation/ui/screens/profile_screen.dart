import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/constants/cache_keys.dart';
import 'package:gamehunt/core/local/cache_helper.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/currency_selection_bottom_sheet.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedCurrency = AppStrings.usdCurrency;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  void _loadUserPreferences() {
    setState(() {
      selectedCurrency =
          CacheHelper.getData(key: CacheKeys.userCurrency) ?? AppStrings.usdCurrency;
    });
  }

  Future<void> _onCurrencyTileTapped() async {
    final selected = await CurrencySelectionBottomSheet.show(
      context,
      selectedCurrency,
    );

    if (selected != null && selected != selectedCurrency) {
      setState(() {
        selectedCurrency = selected;
      });
      await CacheHelper.setData(
        key: CacheKeys.userCurrency,
        value: selected,
      );
    }
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await LogoutDialog.show(context);

    if (shouldLogout == true && mounted) {
      await Supabase.instance.client.auth.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final String userName =
        user?.userMetadata?['full_name'] ?? AppStrings.defaultUserName;
    final String userEmail = user?.email ?? AppStrings.noEmail;

    return Scaffold(
      backgroundColor: ColorsManager.darkBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.darkBackground,
        elevation: 0,
        title: const Text(
          AppStrings.profile,
          style: TextStyles.font24WhiteBold,
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Profile Header (Avatar + Name + Email)
              ProfileHeader(
                userName: userName,
                userEmail: userEmail,
              ),
              const SizedBox(height: 32),

              // Currency Tile
              ProfileTile(
                icon: Icons.attach_money_rounded,
                title: AppStrings.currency,
                trailingText: selectedCurrency,
                onTap: _onCurrencyTileTapped,
              ),
              const SizedBox(height: 12),

              // Logout Tile
              ProfileTile(
                icon: Icons.logout_rounded,
                title: AppStrings.logout,
                titleColor: ColorsManager.redError,
                iconColor: ColorsManager.redError,
                onTap: _handleLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}