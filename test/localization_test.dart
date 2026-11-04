import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monetra/l10n/generated/app_localizations.dart';

void main() {
  group('Multilingual AppLocalizations Tests', () {
    testWidgets('English (en) localization loads correctly', (tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return Text(l10n.safeToSpendToday);
            },
          ),
        ),
      );

      expect(l10n.appName, 'Monetra');
      expect(l10n.safeToSpendToday, 'Safe to Spend Today');
      expect(l10n.navDashboard, 'Dashboard');
      expect(find.text('Safe to Spend Today'), findsOneWidget);
    });

    testWidgets('French (fr) localization loads correctly', (tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return Text(l10n.safeToSpendToday);
            },
          ),
        ),
      );

      expect(l10n.safeToSpendToday, 'Dépense sûre du jour');
      expect(l10n.navDashboard, 'Tableau de bord');
      expect(l10n.monthlyIncome, 'Revenus mensuels');
      expect(find.text('Dépense sûre du jour'), findsOneWidget);
    });

    testWidgets('German (de) localization loads correctly', (tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('de'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return Text(l10n.safeToSpendToday);
            },
          ),
        ),
      );

      expect(l10n.safeToSpendToday, 'Heute verfügbar');
      expect(l10n.navDashboard, 'Übersicht');
      expect(l10n.monthlyExpenses, 'Monatliche Ausgaben');
      expect(find.text('Heute verfügbar'), findsOneWidget);
    });

    testWidgets('Spanish (es) localization loads correctly', (tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return Text(l10n.safeToSpendToday);
            },
          ),
        ),
      );

      expect(l10n.safeToSpendToday, 'Disponible para hoy');
      expect(l10n.navDashboard, 'Inicio');
      expect(l10n.monthlyIncome, 'Ingresos mensuales');
      expect(find.text('Disponible para hoy'), findsOneWidget);
    });

    testWidgets('Portuguese (pt) localization loads correctly', (tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('pt'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return Text(l10n.safeToSpendToday);
            },
          ),
        ),
      );

      expect(l10n.safeToSpendToday, 'Livre para gastar hoje');
      expect(l10n.navDashboard, 'Início');
      expect(l10n.monthlyExpenses, 'Despesas mensais');
      expect(find.text('Livre para gastar hoje'), findsOneWidget);
    });

    testWidgets('Arabic (ar) RTL localization loads correctly', (tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return Text(l10n.safeToSpendToday);
            },
          ),
        ),
      );

      expect(l10n.appName, 'مونيترا');
      expect(l10n.safeToSpendToday, 'المتاح للصرف اليوم');
      expect(l10n.navDashboard, 'الرئيسية');
      expect(find.text('المتاح للصرف اليوم'), findsOneWidget);
    });
  });
}
