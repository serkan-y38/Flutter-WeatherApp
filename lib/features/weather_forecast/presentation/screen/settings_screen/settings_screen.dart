import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/theme_provider.dart';
import '../../../../../core/theme/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  AppTheme? _theme;

  @override
  void initState() {
    super.initState();
    _theme = context.read<ThemeProvider>().currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [_buildThemeSetting()],
      ),
    );
  }

  Widget _buildThemeSetting() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 8),
                  child: Text(
                    "Theme",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  minTileHeight: 48,
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppTheme.systemSetting.name),
                  leading: Radio<AppTheme>(
                    value: AppTheme.systemSetting,
                    groupValue: _theme,
                    onChanged: (AppTheme? value) {
                      setState(() {
                        _theme = value;
                        context.read<ThemeProvider>().setTheme(_theme!);
                      });
                    },
                  ),
                ),
                ListTile(
                  minTileHeight: 48,
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppTheme.dark.name),
                  leading: Radio<AppTheme>(
                    value: AppTheme.dark,
                    groupValue: _theme,
                    onChanged: (AppTheme? value) {
                      setState(() {
                        _theme = value;
                        context.read<ThemeProvider>().setTheme(_theme!);
                      });
                    },
                  ),
                ),
                ListTile(
                  minTileHeight: 48,
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppTheme.light.name),
                  leading: Radio<AppTheme>(
                    value: AppTheme.light,
                    groupValue: _theme,
                    onChanged: (AppTheme? value) {
                      setState(() {
                        _theme = value;
                        context.read<ThemeProvider>().setTheme(_theme!);
                      });
                    },
                  ),
                ),
              ],
            )));
  }
}
