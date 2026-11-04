// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Monetra';

  @override
  String get appTagline => 'Votre argent. Votre vision.';

  @override
  String get appAlternativeTagline => 'Voyez votre argent autrement.';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navTransactions => 'Opérations';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navAnalytics => 'Analyses';

  @override
  String get navGoals => 'Objectifs';

  @override
  String get safeToSpendToday => 'Dépense sûre du jour';

  @override
  String get dailyAllowanceSubtitle =>
      'Allocation quotidienne discrétionnaire calculée';

  @override
  String daysLeftInCycle(int count) {
    return '$count j restants du cycle';
  }

  @override
  String get perDay => '/ jour';

  @override
  String get safeSpendDescription =>
      'Dépensez jusqu\'à ce montant aujourd\'hui sans impacter vos factures ni vos objectifs d\'épargne.';

  @override
  String get safeSpendExceededDescription =>
      'Plafond de budget atteint. Préservez les fonds restants pour vos factures engagées.';

  @override
  String get remainingBudget => 'Budget restant';

  @override
  String get committedBills => 'Factures engagées';

  @override
  String get projectedEnd => 'Fin estimée';

  @override
  String get monthlyIncome => 'Revenus mensuels';

  @override
  String get monthlyExpenses => 'Dépenses mensuelles';

  @override
  String get monthlyBudget => 'Budget mensuel';

  @override
  String get monthlyBudgetUpper => 'BUDGET MENSUEL';

  @override
  String get onTrack => 'Sur la bonne voie';

  @override
  String get attention => 'Attention';

  @override
  String get limitExceeded => 'Plafond dépassé';

  @override
  String consumedPercent(int percent) {
    return '$percent % consommés';
  }

  @override
  String amountRemaining(String amount) {
    return '$amount restants';
  }

  @override
  String amountOverLimit(String amount) {
    return '$amount de dépassement';
  }

  @override
  String get smartInsights => 'ANALYSES INTELLIGENTES';

  @override
  String get insightDailyTargetTitle => 'Objectif de dépense quotidien';

  @override
  String insightDailyTargetMsg(String amount, int days) {
    return 'Dépenser au maximum $amount aujourd\'hui maintient votre budget mensuel sur la bonne voie pour les $days jours restants.';
  }

  @override
  String get insightBudgetAlertTitle => 'Alerte de budget';

  @override
  String get insightBudgetAlertMsg =>
      'Vous avez consommé plus de 90 % de votre budget mensuel. Il est conseillé de limiter les dépenses non essentielles pour sécuriser vos charges fixes.';

  @override
  String get insightRecurringTitle => 'Charges récurrentes';

  @override
  String insightRecurringMsg(String amount) {
    return 'Vous avez des abonnements actifs totalisant $amount/mois. Résilier les services inutilisés pourrait vous faire économiser.';
  }

  @override
  String get insightNetSurplusTitle => 'Excédent net';

  @override
  String insightNetSurplusMsg(String amount) {
    return 'Vous épargnez actuellement $amount ce mois-ci. Envisagez de transférer cet excédent vers vos objectifs d\'épargne.';
  }

  @override
  String get insightSurgeTitle => 'Hausse des dépenses';

  @override
  String insightSurgeMsg(String category, int percent) {
    return '$category représente $percent % de vos dépenses mensuelles.';
  }

  @override
  String get recentActivityUpper => 'ACTIVITÉ RÉCENTE';

  @override
  String get seeAll => 'Voir tout';

  @override
  String get quickLog => 'Ajout rapide';

  @override
  String get noTransactionsYet =>
      'Aucune transaction enregistrée.\nAppuyez sur « + » pour noter votre première dépense.';

  @override
  String get newTransaction => 'Nouvelle opération';

  @override
  String get addExpense => 'Dépense';

  @override
  String get addIncome => 'Revenu';

  @override
  String get amount => 'Montant';

  @override
  String get category => 'Catégorie';

  @override
  String get selectCategory => 'Choisir une catégorie';

  @override
  String get date => 'Date';

  @override
  String get note => 'Note (optionnelle)';

  @override
  String get descriptionPayee => 'Description / Destinataire';

  @override
  String get changeDate => 'Modifier';

  @override
  String get saveExpense => 'Enregistrer la dépense';

  @override
  String get saveIncome => 'Enregistrer le revenu';

  @override
  String get saveTransaction => 'Enregistrer';

  @override
  String get enterValidAmount => 'Veuillez saisir un montant valide';

  @override
  String get activityHistory => 'Activité & Historique';

  @override
  String get searchPlaceholder =>
      'Rechercher par titre, note ou destinataire...';

  @override
  String get filterAll => 'Toutes';

  @override
  String get filterExpenses => 'Dépenses';

  @override
  String get filterIncome => 'Revenus';

  @override
  String get allCategories => 'Toutes les catégories';

  @override
  String get noTransactionsFound => 'Aucune opération trouvée';

  @override
  String get noTransactionsToExport => 'Aucune opération à exporter';

  @override
  String get deleteTransaction => 'Supprimer l\'opération ?';

  @override
  String confirmDeleteTransaction(String title) {
    return 'Voulez-vous vraiment supprimer « $title » ? Cette action est irréversible.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get transactionDeleted => 'Opération supprimée avec succès';

  @override
  String get exportCsv => 'Exporter CSV';

  @override
  String get csvExportSuccess => 'CSV exporté avec succès';

  @override
  String get budgetOverview => 'Budget mensuel';

  @override
  String get createCategoryBudget => 'Créer un budget de catégorie';

  @override
  String get monthlyLimit => 'Plafond mensuel';

  @override
  String get limitPlaceholder => 'ex. 500.00';

  @override
  String get spentOf => 'dépensés sur';

  @override
  String get remaining => 'Restant';

  @override
  String get overBudget => 'Budget dépassé';

  @override
  String get setMonthlyLimit => 'Définir le plafond mensuel';

  @override
  String get setBudget => 'Définir le budget';

  @override
  String get categoryBudgets => 'Budgets par catégorie';

  @override
  String get noCategoryBudgets =>
      'Aucun budget de catégorie créé pour le moment.';

  @override
  String get spendingBreakdown => 'Répartition des dépenses';

  @override
  String get weeklySpendingVelocity => 'Vélocité hebdomadaire';

  @override
  String get noSpendingData => 'Aucune dépense enregistrée cette période';

  @override
  String get highestCategory => 'Catégorie principale';

  @override
  String get financialAnalytics => 'Analyses financières';

  @override
  String get savingsGoals => 'Objectifs d\'épargne';

  @override
  String get newGoal => 'Nouvel objectif';

  @override
  String get targetAmount => 'Montant cible';

  @override
  String get currentSavings => 'Épargné à ce jour';

  @override
  String get recurringSubscriptions => 'Abonnements récurrents';

  @override
  String get newSubscription => 'Ajouter un abonnement';

  @override
  String get monthlyBurnRate => 'Coût mensuel récurrent';

  @override
  String get annualBurnRate => 'Coût annuel récurrent';

  @override
  String get activeSubscriptions => 'Abonnements actifs';

  @override
  String renewsOn(int day) {
    return 'Renouvellement le $day du mois';
  }

  @override
  String get settings => 'Paramètres & Confidentialité';

  @override
  String get preferences => 'PRÉFÉRENCES';

  @override
  String get language => 'Langue';

  @override
  String get languageSubtitle => 'Choisissez votre langue d\'affichage';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get currency => 'Devise principale';

  @override
  String get currencySubtitle => 'Devise d\'affichage des montants';

  @override
  String get appearance => 'Thème & Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get themeLight => 'Clair moderne';

  @override
  String get themeDark => 'Sombre minuit';

  @override
  String get themeOled => 'Noir OLED pur';

  @override
  String get dataPortability => 'PORTABILITÉ & SAUVEGARDE DES DONNÉES';

  @override
  String get backupData => 'Sauvegarder la base (JSON)';

  @override
  String get backupSubtitle => 'Exporter une sauvegarde locale complète';

  @override
  String get restoreData => 'Restaurer la base (JSON)';

  @override
  String get restoreSubtitle => 'Importer un fichier de sauvegarde';

  @override
  String get seedSampleData => 'Charger des données d\'exemple';

  @override
  String get seedSampleSubtitle =>
      'Génère des revenus, factures et objectifs d\'essai';

  @override
  String get sampleDataLoaded => 'Données d\'exemple chargées avec succès !';

  @override
  String get security => 'SÉCURITÉ & CONFIDENTIALITÉ';

  @override
  String get biometricLock => 'Verrouillage biométrique';

  @override
  String get biometricSubtitle =>
      'Déverrouillez Monetra par empreinte ou Face ID';

  @override
  String get biometricPrompt =>
      'Veuillez vous authentifier pour accéder à Monetra';

  @override
  String get dataSovereignty => '100% Hors-ligne & Privé';

  @override
  String get dataSovereigntySubtitle =>
      'Vos données financières restent exclusivement sur votre appareil.';

  @override
  String get version => 'Version';

  @override
  String get catHousing => 'Logement & Loyer';

  @override
  String get catFood => 'Alimentation & Courses';

  @override
  String get catTransport => 'Transports & Mobilité';

  @override
  String get catShopping => 'Shopping & Achats';

  @override
  String get catEntertainment => 'Loisirs & Sorties';

  @override
  String get catHealth => 'Santé & Soins';

  @override
  String get catEducation => 'Éducation & Formation';

  @override
  String get catTravel => 'Voyages & Vacances';

  @override
  String get catBills => 'Factures & Services';

  @override
  String get catSubscriptions => 'Abonnements';

  @override
  String get catPersonalCare => 'Soins personnels';

  @override
  String get catSavingsTransfers => 'Épargne & Virements';

  @override
  String get catOtherExpense => 'Autres dépenses';

  @override
  String get catSalary => 'Salaire & Revenus';

  @override
  String get catFreelance => 'Freelance & Affaires';

  @override
  String get catInvestments => 'Investissements & Dividendes';

  @override
  String get catGifts => 'Cadeaux & Remboursements';

  @override
  String get catOtherIncome => 'Autres revenus';

  @override
  String get catOther => 'Autre';

  @override
  String get welcomeTitle => 'Voyez votre argent autrement';

  @override
  String get welcomeSubtitle =>
      'Finances personnelles visuelles, intelligentes et 100% privées.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get slide1Title => 'Dépense sûre du jour';

  @override
  String get slide1Desc =>
      'Ne vous demandez plus si vous pouvez vous offrir un déjeuner. Obtenez un budget quotidien calculé qui préserve vos factures.';

  @override
  String get slide2Title => 'Zéro fouillis, pure clarté';

  @override
  String get slide2Desc =>
      'Anneaux de progression, graphiques en anneau et tendances instantanées sans tableurs complexes.';

  @override
  String get slide3Title => '100% Hors-ligne & Souveraineté';

  @override
  String get slide3Desc =>
      'Aucun identifiant bancaire requis. Vos données financières sont chiffrées localement sur votre téléphone.';

  @override
  String get selectCurrencyTitle => 'Sélectionnez votre devise';

  @override
  String get startExploring => 'Lancer Monetra';

  @override
  String get period7Days => '7 Jours';

  @override
  String get period30Days => '30 Jours';

  @override
  String get period3Months => '3 Mois';

  @override
  String get periodAllTime => 'Tout l\'historique';

  @override
  String get period7DaysTitle => 'Vélocité sur 7 jours';

  @override
  String get period30DaysTitle => 'Tendance sur 30 jours';

  @override
  String get period3MonthsTitle => 'Comparaison sur 3 mois';

  @override
  String get periodAllTimeTitle => 'Évolution mensuelle des dépenses';

  @override
  String get incomeVsExpenses => 'Revenus vs Dépenses';

  @override
  String get inflow => 'Entrées';

  @override
  String get outflow => 'Sorties';

  @override
  String get netBalance => 'Solde net';

  @override
  String get spendingDistribution => 'Répartition des dépenses';

  @override
  String get categoryBreakdown => 'Détail par catégorie';

  @override
  String get noTransactionsTimeframe => 'Aucune transaction sur cette période.';

  @override
  String pctOfTotalSpending(String percent) {
    return '$percent% des dépenses totales';
  }

  @override
  String activeTargetsCount(int count) {
    return 'Objectifs actifs ($count)';
  }

  @override
  String get noSavingsGoals =>
      'Aucun objectif d\'épargne. Créez-en un pour rester motivé !';

  @override
  String targetLabel(String amount) {
    return 'Objectif : $amount';
  }

  @override
  String savedLabel(String amount) {
    return 'Épargné : $amount';
  }

  @override
  String get addFunds => 'Verser des fonds';

  @override
  String contributeTo(String name) {
    return 'Contribuer à « $name »';
  }

  @override
  String get contributionAmount => 'Montant du versement';

  @override
  String depositedSuccess(String amount, String name) {
    return '$amount déposés sur $name !';
  }

  @override
  String get createSavingsGoal => 'Créer un objectif d\'épargne';

  @override
  String get goalNameLabel => 'Nom de l\'objectif (ex. Nouvel ordinateur)';

  @override
  String get targetAmountLabel => 'Montant cible';

  @override
  String get targetDateLabel => 'Date cible';

  @override
  String get createGoal => 'Créer l\'objectif';

  @override
  String get monthlyCommitment => 'Engagement mensuel';

  @override
  String get annualProjection => 'Projection annuelle';

  @override
  String subscriptionsAndBillsCount(int count) {
    return 'Abonnements & Charges ($count)';
  }

  @override
  String get addBill => 'Ajouter une charge';

  @override
  String get noSubscriptionsYet => 'Aucun abonnement récurrent enregistré.';

  @override
  String get chooseAppearance => 'Choisir l\'apparence';

  @override
  String get restoreBackupTitle => 'Restaurer la sauvegarde ?';

  @override
  String get restoreBackupConfirm =>
      'Cette restauration remplacera les transactions, budgets et objectifs actuels par les données sauvegardées. Continuer ?';

  @override
  String get restoreDataBtn => 'Restaurer les données';

  @override
  String backupExportError(String error) {
    return 'Erreur d\'export : $error';
  }

  @override
  String get backupInvalidFormat => 'Format de sauvegarde Monetra non valide.';

  @override
  String restoreBackupError(String error) {
    return 'Erreur de restauration : $error';
  }

  @override
  String get biometricsNotAvailable =>
      'Biométrie non disponible sur cet appareil';

  @override
  String biometricsFailed(String error) {
    return 'Échec de l\'authentification biométrique : $error';
  }

  @override
  String get commitmentsUpToDate =>
      'Tous vos engagements financiers sont à jour !';

  @override
  String get addSubscriptionTitle => 'Ajouter un abonnement récurrent';

  @override
  String get serviceNameLabel => 'Nom du service (ex. Netflix, Salle de sport)';

  @override
  String get amountPerCycleLabel => 'Montant par cycle';

  @override
  String get billingFrequencyLabel => 'Fréquence de facturation';

  @override
  String get billingMonthly => 'Mensuel';

  @override
  String get billingWeekly => 'Hebdomadaire';

  @override
  String get billingQuarterly => 'Trimestriel';

  @override
  String get billingYearly => 'Annuel';

  @override
  String get saveSubscription => 'Enregistrer l\'abonnement';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get txSampleSalary => 'Versement salaire mensuel';

  @override
  String get txSampleRent => 'Loyer de l\'appartement';

  @override
  String get txSampleGroceries => 'Courses supermarché';

  @override
  String get txSampleTransport => 'Passe transport & Carburant';

  @override
  String get txSampleEntertainment => 'Cinéma & Dîner du week-end';
}
