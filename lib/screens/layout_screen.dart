import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/l10n/app_localizations.dart';
import 'package:job_seeker/providers/auth_provider.dart';
import 'package:job_seeker/core/auth/auth_dialog_manager.dart';
import 'package:job_seeker/screens/Profile/profile_screen.dart';
import 'package:job_seeker/widgets/notification_bell_widget.dart';
import 'package:job_seeker/services/update_service.dart';

import 'applications_screen.dart';
import 'home_screen.dart';
import 'jobs_screen.dart';
import 'auth/login_screen.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  const LayoutScreen({super.key});

  @override
  ConsumerState<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  int currentIndex = 0;
  bool _hasHandledInitialAuth = false;
  bool _isSessionExpiredDialogShown = false;

  final List<Widget> _screens = const <Widget>[
    HomeScreen(),
    JobsScreen(),
    ApplicationsScreen(),
    ProfileScreen(),
  ];

  void _onDestinationSelected(int index) {
    if (index != currentIndex) {
      HapticFeedback.lightImpact();
      setState(() {
        currentIndex = index;
      });
    }
  }

  void _showSessionExpiredDialog() {
    if (_isSessionExpiredDialogShown) return;
    _isSessionExpiredDialogShown = true;
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.error),
        content: Text(l10n.loggingOut),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: Text(l10n.ok),
          ),
        ],
      ),
    ).then((_) {
      _isSessionExpiredDialogShown = false;
      AuthDialogManager().resetSessionExpired();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final updateState = ref.read(updateStateProvider);
      if (updateState.status == UpdateStatus.mandatory) {
        _showMandatoryUpdateDialog(context, updateState);
      } else if (updateState.status == UpdateStatus.optional && !updateState.isSnoozed) {
        _showOptionalUpdateBottomSheet(context, ref, updateState);
      }
    });
  }

  void _showOptionalUpdateBottomSheet(BuildContext context, WidgetRef ref, UpdateState updateState) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.system_update_rounded, color: Colors.blue, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      l10n.updateAvailable,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.updateVersionReady(updateState.latestVersion ?? ''),
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.4),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(updateStateProvider.notifier).snoozeUpdate();
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: Text(l10n.updateLater),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          UpdateNotifier.launchUpdateUrl(updateState.apkUrl!);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4E60FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(l10n.updateAction),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMandatoryUpdateDialog(BuildContext context, UpdateState updateState) {
    final l10n = AppLocalizations.of(context)!;
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.security_rounded, color: Colors.red, size: 40),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.mandatoryUpdateTitle,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.mandatoryUpdateBody,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => UpdateNotifier.launchUpdateUrl(updateState.apkUrl!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(l10n.updateAction, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey.shade500,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(l10n.exitApp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen<UpdateState>(updateStateProvider, (previous, next) {
      if (next.status == UpdateStatus.mandatory) {
        _showMandatoryUpdateDialog(context, next);
      } else if (next.status == UpdateStatus.optional && !next.isSnoozed) {
        _showOptionalUpdateBottomSheet(context, ref, next);
      }
    });

    final updateState = ref.watch(updateStateProvider);
    final hasUpdate = updateState.status == UpdateStatus.optional;
    
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated && mounted) {
        if (next.sessionExpired) {
          _showSessionExpiredDialog();
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      }
    });

    if (!_hasHandledInitialAuth) {
      _hasHandledInitialAuth = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentState = ref.read(authProvider);
        if (currentState.status == AuthStatus.unauthenticated && mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      });
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titles = [l10n.home, l10n.exploreJobs, l10n.myApplications, l10n.profile];
    final navItems = [
      _NavItem(icon: Icons.grid_view_rounded, activeIcon: Icons.grid_view_rounded, label: l10n.home),
      _NavItem(icon: Icons.search_rounded, activeIcon: Icons.search_rounded, label: l10n.jobs),
      _NavItem(icon: Icons.description_outlined, activeIcon: Icons.description_rounded, label: l10n.applied),
      _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: l10n.profile),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        toolbarHeight: 48,
        backgroundColor: colorScheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        actions: const [NotificationBellWidget(), SizedBox(width: 8)],
      ),
      body: Stack(
        children: [
          // Background - IgnorePointer to prevent blocking taps
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colorScheme.surface, const Color(0xFFF8F9FE)],
                ),
              ),
            ),
          ),

          IndexedStack(index: currentIndex, children: _screens),
        ],
      ),
      bottomNavigationBar: _GlassBottomNav(
        items: navItems,
        currentIndex: currentIndex,
        onTap: _onDestinationSelected,
        hasUpdate: hasUpdate,
      ),
    );
  }
}

class _GlassBottomNav extends StatelessWidget {
  final List<_NavItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final bool hasUpdate;

  const _GlassBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.hasUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF4E60FF); // Vibrant Blue for active

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Blur Layer
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 72, // Slightly Taller for labels
                width: double.infinity,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),

          // Border Layer
          IgnorePointer(
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),

          // Content Layer
          Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, (index) {
                final isSelected = index == currentIndex;
                return GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 64, // Fixed target width
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                isSelected
                                    ? items[index].activeIcon
                                    : items[index].icon,
                                color: isSelected
                                    ? primaryColor
                                    : Colors.grey.shade500,
                                size: 26,
                              ),
                              if (index == 3 && hasUpdate)
                                Positioned(
                                  top: -2,
                                  right: -2,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontFamily: 'Inter', // Assuming Inter is used
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? primaryColor
                                : Colors.grey.shade500,
                          ),
                          child: Text(items[index].label),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
