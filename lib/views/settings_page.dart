import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/theme/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/cubit/locale_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const _prefsKeyNotifications = 'notifications_enabled';

  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _notificationsEnabled = prefs.getBool(_prefsKeyNotifications) ?? true;
    });
  }

  Future<void> _onNotificationsChanged(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyNotifications, enabled);
    if (!mounted) return;
    setState(() => _notificationsEnabled = enabled);

    if (!enabled) {
      await FlutterLocalNotificationsPlugin().cancelAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          locale.tn('Settings', 'الإعدادات'),
          style: const TextStyle(
            color: AppStyle.originalPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          _NotificationsCard(
            locale: locale,
            enabled: _notificationsEnabled,
            onChanged: _onNotificationsChanged,
          ),
          const SizedBox(height: 20),
          _LanguageCard(locale: locale),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  static const Color _surface = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _NotificationsCard extends StatelessWidget {
  const _NotificationsCard({
    required this.locale,
    required this.enabled,
    required this.onChanged,
  });

  final LocaleCubit locale;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: SwitchListTile(
        title: Text(
          locale.tn('Notifications', 'الإشعارات'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          locale.tn('Allow daily news alerts', 'تفعيل تنبيهات الأخبار اليومية'),
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        value: enabled,
        activeThumbColor: AppStyle.originalPrimaryColor,
        activeTrackColor: AppStyle.originalPrimaryColor.withValues(alpha: 0.4),
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        onChanged: onChanged,
        secondary: Icon(
          enabled ? Icons.notifications_active : Icons.notifications_off,
          color: enabled ? AppStyle.originalPrimaryColor : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.label,
    required this.flag,
  });

  final String code;
  final String label;
  final String flag;
}

const _kLanguageOptions = [
  _LanguageOption(code: 'en', label: 'English', flag: '🇺🇸'),
  _LanguageOption(code: 'ar', label: 'العربية', flag: '🇸🇦'),
];

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({required this.locale});

  final LocaleCubit locale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.language,
                  color: AppStyle.originalPrimaryColor,
                  size: 28,
                ),
                const SizedBox(width: 14),
                Text(
                  locale.tn('Language', 'اللغة'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            for (final option in _kLanguageOptions)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _LanguageTile(
                  option: option,
                  selected: locale.languageCode == option.code,
                  onSelect: () => locale.setLanguage(option.code),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.option,
    required this.selected,
    required this.onSelect,
  });

  final _LanguageOption option;
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final primary = AppStyle.originalPrimaryColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? primary : Colors.grey.withValues(alpha: 0.3),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(option.flag, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Text(
                option.label,
                style: TextStyle(
                  color: selected ? primary : Colors.white,
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (selected) Icon(Icons.check_circle, color: primary, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
