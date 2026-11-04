// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'مونيترا';

  @override
  String get appTagline => 'أموالك. رؤيتك.';

  @override
  String get appAlternativeTagline => 'انظر إلى أموالك بمنظور مختلف.';

  @override
  String get navDashboard => 'الرئيسية';

  @override
  String get navTransactions => 'المعاملات';

  @override
  String get navBudgets => 'الميزانيات';

  @override
  String get navAnalytics => 'التحليلات';

  @override
  String get navGoals => 'الأهداف';

  @override
  String get safeToSpendToday => 'المتاح للصرف اليوم';

  @override
  String get dailyAllowanceSubtitle => 'حد الصرف اليومي التقديري الآمن';

  @override
  String daysLeftInCycle(int count) {
    return '$count يوم متبقٍ في الدورة';
  }

  @override
  String get perDay => '/ اليوم';

  @override
  String get safeSpendDescription =>
      'يمكنك صرف هذا المبلغ اليوم بأمان دون التأثير على فواتيرك أو أهدافك الادخارية.';

  @override
  String get safeSpendExceededDescription =>
      'تم الوصول إلى الحد الأقصى للميزانية. يرجى تخصيص الرصيد المتبقي للفواتير الأساسية.';

  @override
  String get remainingBudget => 'الميزانية المتبقية';

  @override
  String get committedBills => 'الفواتير والالتزامات';

  @override
  String get projectedEnd => 'المصروف المتوقع';

  @override
  String get monthlyIncome => 'الدخل الشهري';

  @override
  String get monthlyExpenses => 'المصاريف الشهرية';

  @override
  String get monthlyBudget => 'الميزانية الشهرية';

  @override
  String get monthlyBudgetUpper => 'الميزانية الشهرية';

  @override
  String get onTrack => 'ضمن الخطة';

  @override
  String get attention => 'انتباه';

  @override
  String get limitExceeded => 'تجاوز الحد';

  @override
  String consumedPercent(int percent) {
    return 'تم استهلاك $percent%';
  }

  @override
  String amountRemaining(String amount) {
    return 'متبقٍ $amount';
  }

  @override
  String amountOverLimit(String amount) {
    return 'تجاوز بمقدار $amount';
  }

  @override
  String get smartInsights => 'تحليلات ورؤى ذكية';

  @override
  String get insightDailyTargetTitle => 'المعدل اليومي للصرف';

  @override
  String insightDailyTargetMsg(String amount, int days) {
    return 'الالتزام بمبلغ $amount اليوم يحافظ على ميزانيتك الشهرية آمنة للأيام الـ $days المتبقية.';
  }

  @override
  String get insightBudgetAlertTitle => 'تنبيه الميزانية';

  @override
  String get insightBudgetAlertMsg =>
      'لقد استهلكت أكثر من 90% من ميزانيتك الشهرية. يُنصح بإيقاف المصاريف غير الأساسية لحماية الالتزامات.';

  @override
  String get insightRecurringTitle => 'الاشتراكات الدورية';

  @override
  String insightRecurringMsg(String amount) {
    return 'لديك اشتراكات نشطة بإجمالي $amount/شهر. مراجعة الخدمات غير المستخدمة قد يوفر لك المال.';
  }

  @override
  String get insightNetSurplusTitle => 'فائض مالي إيجابي';

  @override
  String insightNetSurplusMsg(String amount) {
    return 'أنت توفر حالياً $amount هذا الشهر. يمكنك توجيه هذا الفائض نحو أهدافك الادخارية.';
  }

  @override
  String get insightSurgeTitle => 'ارتفاع في وتيرة الصرف';

  @override
  String insightSurgeMsg(String category, int percent) {
    return 'تمثل فئة $category ما نسبته $percent% من مصاريفك هذا الشهر.';
  }

  @override
  String get recentActivityUpper => 'النشاط الأخير';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get quickLog => 'تسجيل سريع';

  @override
  String get noTransactionsYet =>
      'لا توجد معاملات بعد.\nاضغط على «+» لتسجيل أول عملية صرف.';

  @override
  String get newTransaction => 'معاملة جديدة';

  @override
  String get addExpense => 'مصروف';

  @override
  String get addIncome => 'دخل';

  @override
  String get amount => 'المبلغ';

  @override
  String get category => 'الفئة';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get date => 'التاريخ';

  @override
  String get note => 'ملاحظة (اختياري)';

  @override
  String get descriptionPayee => 'الوصف / الجهة';

  @override
  String get changeDate => 'تعديل';

  @override
  String get saveExpense => 'حفظ المصروف';

  @override
  String get saveIncome => 'حفظ الدخل';

  @override
  String get saveTransaction => 'حفظ';

  @override
  String get enterValidAmount => 'يرجى إدخال مبلغ صحيح';

  @override
  String get activityHistory => 'النشاط والمعاملات';

  @override
  String get searchPlaceholder => 'بحث بالاسم، الملاحظة أو الجهة...';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterExpenses => 'المصاريف';

  @override
  String get filterIncome => 'الدخل';

  @override
  String get allCategories => 'جميع الفئات';

  @override
  String get noTransactionsFound => 'لا توجد معاملات مسجلة';

  @override
  String get noTransactionsToExport => 'لا توجد معاملات لتصديرها';

  @override
  String get deleteTransaction => 'حذف المعاملة؟';

  @override
  String confirmDeleteTransaction(String title) {
    return 'هل أنت متأكد من رغبتك في حذف «$title»؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get transactionDeleted => 'تم حذف المعاملة بنجاح';

  @override
  String get exportCsv => 'تصدير CSV';

  @override
  String get csvExportSuccess => 'تم تصدير ملف CSV بنجاح';

  @override
  String get budgetOverview => 'الميزانية الشهرية';

  @override
  String get createCategoryBudget => 'إنشاء ميزانية للفئة';

  @override
  String get monthlyLimit => 'الحد الأقصى الشهري';

  @override
  String get limitPlaceholder => 'مثال: 500.00';

  @override
  String get spentOf => 'مصروف من';

  @override
  String get remaining => 'المتبقي';

  @override
  String get overBudget => 'تجاوز الميزانية';

  @override
  String get setMonthlyLimit => 'تحديد الحد الأقصى الشهري';

  @override
  String get setBudget => 'حفظ الميزانية';

  @override
  String get categoryBudgets => 'ميزانيات الفئات';

  @override
  String get noCategoryBudgets => 'لم يتم إنشاء أي ميزانيات للفئات بعد.';

  @override
  String get spendingBreakdown => 'توزيع المصاريف';

  @override
  String get weeklySpendingVelocity => 'وتيرة الإنفاق الأسبوعية';

  @override
  String get noSpendingData => 'لا توجد مصاريف مسجلة لهذه الفترة';

  @override
  String get highestCategory => 'أعلى فئة صرف';

  @override
  String get financialAnalytics => 'التحليلات المالية';

  @override
  String get savingsGoals => 'أهداف الادخار';

  @override
  String get newGoal => 'هدف جديد';

  @override
  String get targetAmount => 'المبلغ المستهدف';

  @override
  String get currentSavings => 'تم توفيره حتى الآن';

  @override
  String get recurringSubscriptions => 'الاشتراكات الدورية';

  @override
  String get newSubscription => 'إضافة اشتراك';

  @override
  String get monthlyBurnRate => 'التكلفة الشهرية الثابتة';

  @override
  String get annualBurnRate => 'التكلفة السنوية الثابتة';

  @override
  String get activeSubscriptions => 'الاشتراكات الفعالة';

  @override
  String renewsOn(int day) {
    return 'يتجدد في يوم $day من الشهر';
  }

  @override
  String get settings => 'الإعدادات والخصوصية';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get language => 'اللغة';

  @override
  String get languageSubtitle => 'اختر لغة التطبيق المفضلة';

  @override
  String get systemDefault => 'تلقائي حسب نظام الهاتف';

  @override
  String get currency => 'العملة الأساسية';

  @override
  String get currencySubtitle => 'عملة عرض الأرقام والمعاملات';

  @override
  String get appearance => 'المظهر والنمط';

  @override
  String get theme => 'النمط';

  @override
  String get themeLight => 'فاتح عصري';

  @override
  String get themeDark => 'داكن ليلي';

  @override
  String get themeOled => 'أسود OLED نقي';

  @override
  String get dataPortability => 'نقل البيانات والنسخ الاحتياطي';

  @override
  String get backupData => 'نسخ احتياطي للبيانات (JSON)';

  @override
  String get backupSubtitle => 'تصدير نسخة احتياطية محلية كاملة';

  @override
  String get restoreData => 'استعادة البيانات (JSON)';

  @override
  String get restoreSubtitle => 'استيراد ملف نسخة احتياطية';

  @override
  String get seedSampleData => 'تحميل بيانات تجريبية';

  @override
  String get seedSampleSubtitle => 'إضافة دخل ونفقات وأهداف توضيحية';

  @override
  String get sampleDataLoaded => 'تم تحميل البيانات التجريبية بنجاح!';

  @override
  String get security => 'الأمان والخصوصية';

  @override
  String get biometricLock => 'القفل الحيوي';

  @override
  String get biometricSubtitle => 'فتح مونيترا ببصمة الإصبع أو بصمة الوجه';

  @override
  String get biometricPrompt => 'يرجى التحقق لتسجيل الدخول إلى مونيترا';

  @override
  String get dataSovereignty => '100% دون اتصال وبخصوصية تامة';

  @override
  String get dataSovereigntySubtitle =>
      'بياناتك المالية مشفرة ومحفوظة حصرياً على هاتفك.';

  @override
  String get version => 'الإصدار';

  @override
  String get catHousing => 'السكن والإيجار';

  @override
  String get catFood => 'الطعام والبقالة';

  @override
  String get catTransport => 'المواصلات والنقل';

  @override
  String get catShopping => 'التسوق والمشتريات';

  @override
  String get catEntertainment => 'الترفيه والأنشطة';

  @override
  String get catHealth => 'الصحة والرعاية الطبية';

  @override
  String get catEducation => 'التعليم والدورات';

  @override
  String get catTravel => 'السفر والعطلات';

  @override
  String get catBills => 'الفواتير والخدمات';

  @override
  String get catSubscriptions => 'الاشتراكات الدورية';

  @override
  String get catPersonalCare => 'العناية الشخصية';

  @override
  String get catSavingsTransfers => 'المدخرات والتحويلات';

  @override
  String get catOtherExpense => 'مصاريف أخرى';

  @override
  String get catSalary => 'الراتب والدخل الأساسي';

  @override
  String get catFreelance => 'العمل الحر والمشاريع';

  @override
  String get catInvestments => 'عائدات الاستثمار';

  @override
  String get catGifts => 'الهدايا والمكافآت';

  @override
  String get catOtherIncome => 'دخل آخر';

  @override
  String get catOther => 'أخرى';

  @override
  String get welcomeTitle => 'انظر إلى أموالك بمنظور مختلف';

  @override
  String get welcomeSubtitle => 'إدارة مالية ذكية، بصرية، ومحلية بخصوصية 100%.';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get slide1Title => 'المتاح للصرف اليوم';

  @override
  String get slide1Desc =>
      'لا داعي للحيرة قبل أي وجبة أو قهوة. احصل على ميزانية يومية ذكية تحمي فواتيرك والتزاماتك.';

  @override
  String get slide2Title => 'وضوح كامل دون تعقيد';

  @override
  String get slide2Desc =>
      'حلقات تقدم ملهمة ورسوم بيانية ذكية دون فوضى الجداول الحسابية.';

  @override
  String get slide3Title => 'خصوصية محلية 100%';

  @override
  String get slide3Desc =>
      'لا نطلب كلمات مرور بنكية. كل معاملاتك مشفرة ومخزنة حصرياً على هاتفك.';

  @override
  String get selectCurrencyTitle => 'اختر عملتك الأساسية';

  @override
  String get startExploring => 'ابدأ استخدام مونيترا';

  @override
  String get period7Days => '٧ أيام';

  @override
  String get period30Days => '٣٠ يوماً';

  @override
  String get period3Months => '٣ أشهر';

  @override
  String get periodAllTime => 'كل الأوقات';

  @override
  String get period7DaysTitle => 'سرعة الإنفاق لـ 7 أيام';

  @override
  String get period30DaysTitle => 'اتجاه الإنفاق لـ 30 يومًا';

  @override
  String get period3MonthsTitle => 'مقارنة الإنفاق لـ 3 أشهر';

  @override
  String get periodAllTimeTitle => 'تطور الإنفاق الشهري';

  @override
  String get incomeVsExpenses => 'الدخل مقابل المصاريف';

  @override
  String get inflow => 'الإيرادات';

  @override
  String get outflow => 'المصروفات';

  @override
  String get netBalance => 'صافي الرصيد';

  @override
  String get spendingDistribution => 'توزيع المصاريف';

  @override
  String get categoryBreakdown => 'تفصيل الفئات';

  @override
  String get noTransactionsTimeframe =>
      'لا توجد معاملات مسجلة في هذا النطاق الزمني.';

  @override
  String pctOfTotalSpending(String percent) {
    return '$percent٪ من إجمالي الإنفاق';
  }

  @override
  String activeTargetsCount(int count) {
    return 'الأهداف النشطة ($count)';
  }

  @override
  String get noSavingsGoals =>
      'لا توجد أهداف ادخار حالياً. أنشئ هدفاً لتصل إلى أحلامك المالية!';

  @override
  String targetLabel(String amount) {
    return 'الهدف: $amount';
  }

  @override
  String savedLabel(String amount) {
    return 'تم ادخار: $amount';
  }

  @override
  String get addFunds => 'إيداع أموال';

  @override
  String contributeTo(String name) {
    return 'إيداع في «$name»';
  }

  @override
  String get contributionAmount => 'مبلغ الإيداع';

  @override
  String depositedSuccess(String amount, String name) {
    return 'تم إيداع $amount في $name بنجاح!';
  }

  @override
  String get createSavingsGoal => 'إنشاء هدف ادخار جديد';

  @override
  String get goalNameLabel => 'اسم الهدف (مثلاً: حاسوب محمول)';

  @override
  String get targetAmountLabel => 'المبلغ المستهدف';

  @override
  String get targetDateLabel => 'تاريخ تحقيق الهدف';

  @override
  String get createGoal => 'حفظ الهدف';

  @override
  String get monthlyCommitment => 'الالتزام الشهري';

  @override
  String get annualProjection => 'التقدير السنوي';

  @override
  String subscriptionsAndBillsCount(int count) {
    return 'الاشتراكات والفواتير ($count)';
  }

  @override
  String get addBill => 'إضافة التزام';

  @override
  String get noSubscriptionsYet => 'لم يتم تسجيل أي اشتراكات دورية بعد.';

  @override
  String get chooseAppearance => 'اختيار المظهر والنمط';

  @override
  String get restoreBackupTitle => 'استعادة النسخة الاحتياطية؟';

  @override
  String get restoreBackupConfirm =>
      'استعادة هذه النسخة ستستبدل المعاملات والميزانيات الحالية بالبيانات المحفوظة. هل تريد المتابعة؟';

  @override
  String get restoreDataBtn => 'استعادة البيانات';

  @override
  String backupExportError(String error) {
    return 'خطأ أثناء تصدير النسخة الاحتياطية: $error';
  }

  @override
  String get backupInvalidFormat => 'تنسيق ملف النسخة الاحتياطية غير صالح.';

  @override
  String restoreBackupError(String error) {
    return 'خطأ أثناء استعادة النسخة الاحتياطية: $error';
  }

  @override
  String get biometricsNotAvailable =>
      'المصادقة البيومترية غير متوفرة على هذا الجهاز';

  @override
  String biometricsFailed(String error) {
    return 'فشلت المصادقة البيومترية: $error';
  }

  @override
  String get commitmentsUpToDate => 'جميع الالتزامات المالية محدثة تماماً!';

  @override
  String get addSubscriptionTitle => 'إضافة اشتراك أو فاتورة دورية';

  @override
  String get serviceNameLabel => 'اسم الخدمة (مثلاً: نيتفليكس، نادي رياضي)';

  @override
  String get amountPerCycleLabel => 'المبلغ لكل دورة';

  @override
  String get billingFrequencyLabel => 'تكرار الفوترة';

  @override
  String get billingMonthly => 'شهرياً';

  @override
  String get billingWeekly => 'أسبوعياً';

  @override
  String get billingQuarterly => 'ربع سنوي';

  @override
  String get billingYearly => 'سنوياً';

  @override
  String get saveSubscription => 'حفظ الاشتراك';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get txSampleSalary => 'إيداع الراتب الشهري';

  @override
  String get txSampleRent => 'إيجار السكن';

  @override
  String get txSampleGroceries => 'مشتريات البقالة والسوبرماركت';

  @override
  String get txSampleTransport => 'اشتراك المواصلات والوقود';

  @override
  String get txSampleEntertainment => 'عشاء وسينما نهاية الأسبوع';
}
