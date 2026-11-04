// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Monetra';

  @override
  String get appTagline => 'Tu dinero. Tu visión.';

  @override
  String get appAlternativeTagline => 'Mira tu dinero de forma diferente.';

  @override
  String get navDashboard => 'Inicio';

  @override
  String get navTransactions => 'Movimientos';

  @override
  String get navBudgets => 'Presupuestos';

  @override
  String get navAnalytics => 'Análisis';

  @override
  String get navGoals => 'Metas';

  @override
  String get safeToSpendToday => 'Disponible para hoy';

  @override
  String get dailyAllowanceSubtitle => 'Límite de gasto diario calculado';

  @override
  String daysLeftInCycle(int count) {
    return '$count d restantes del ciclo';
  }

  @override
  String get perDay => '/ día';

  @override
  String get safeSpendDescription =>
      'Gasta hasta este monto hoy sin comprometer tus facturas ni tus metas de ahorro.';

  @override
  String get safeSpendExceededDescription =>
      'Límite de presupuesto alcanzado. Reserva los fondos restantes para facturas comprometidas.';

  @override
  String get remainingBudget => 'Presupuesto restante';

  @override
  String get committedBills => 'Facturas fijas';

  @override
  String get projectedEnd => 'Proyección fin de mes';

  @override
  String get monthlyIncome => 'Ingresos mensuales';

  @override
  String get monthlyExpenses => 'Gastos mensuales';

  @override
  String get monthlyBudget => 'Presupuesto mensual';

  @override
  String get monthlyBudgetUpper => 'PRESUPUESTO MENSUAL';

  @override
  String get onTrack => 'Bajo control';

  @override
  String get attention => 'Atención';

  @override
  String get limitExceeded => 'Límite superado';

  @override
  String consumedPercent(int percent) {
    return '$percent% consumido';
  }

  @override
  String amountRemaining(String amount) {
    return '$amount restante';
  }

  @override
  String amountOverLimit(String amount) {
    return '$amount de exceso';
  }

  @override
  String get smartInsights => 'ANÁLISIS INTELIGENTES';

  @override
  String get insightDailyTargetTitle => 'Meta diaria de gasto';

  @override
  String insightDailyTargetMsg(String amount, int days) {
    return 'Mantenerte hoy dentro de $amount asegura que tu presupuesto mensual continúe bajo control para los $days días restantes.';
  }

  @override
  String get insightBudgetAlertTitle => 'Alerta de presupuesto';

  @override
  String get insightBudgetAlertMsg =>
      'Has consumido más del 90% de tu presupuesto mensual. Conviene pausar gastos no esenciales para proteger tus pagos fijos.';

  @override
  String get insightRecurringTitle => 'Compromisos recurrentes';

  @override
  String insightRecurringMsg(String amount) {
    return 'Tienes suscripciones activas por un total de $amount/mes. Cancelar servicios en desuso te permitirá ahorrar dinero.';
  }

  @override
  String get insightNetSurplusTitle => 'Superávit positivo';

  @override
  String insightNetSurplusMsg(String amount) {
    return 'Estás ahorrando actualmente $amount este mes. Considera transferir este excedente a tus metas de ahorro.';
  }

  @override
  String get insightSurgeTitle => 'Aumento de gasto';

  @override
  String insightSurgeMsg(String category, int percent) {
    return '$category representa el $percent% de tus gastos totales del mes.';
  }

  @override
  String get recentActivityUpper => 'ACTIVIDAD RECIENTE';

  @override
  String get seeAll => 'Ver todo';

  @override
  String get quickLog => 'Registro rápido';

  @override
  String get noTransactionsYet =>
      'Aún no hay movimientos registrados.\nToca «+» para anotar tu primer gasto.';

  @override
  String get newTransaction => 'Nuevo movimiento';

  @override
  String get addExpense => 'Gasto';

  @override
  String get addIncome => 'Ingreso';

  @override
  String get amount => 'Monto';

  @override
  String get category => 'Categoría';

  @override
  String get selectCategory => 'Seleccionar categoría';

  @override
  String get date => 'Fecha';

  @override
  String get note => 'Nota (opcional)';

  @override
  String get descriptionPayee => 'Descripción / Beneficiario';

  @override
  String get changeDate => 'Cambiar';

  @override
  String get saveExpense => 'Guardar gasto';

  @override
  String get saveIncome => 'Guardar ingreso';

  @override
  String get saveTransaction => 'Guardar';

  @override
  String get enterValidAmount => 'Por favor introduce un monto válido';

  @override
  String get activityHistory => 'Actividad e Historial';

  @override
  String get searchPlaceholder => 'Buscar por título, nota o beneficiario...';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterExpenses => 'Gastos';

  @override
  String get filterIncome => 'Ingresos';

  @override
  String get allCategories => 'Todas las categorías';

  @override
  String get noTransactionsFound => 'No se encontraron movimientos';

  @override
  String get noTransactionsToExport => 'No hay movimientos para exportar';

  @override
  String get deleteTransaction => '¿Eliminar movimiento?';

  @override
  String confirmDeleteTransaction(String title) {
    return '¿Seguro que deseas eliminar «$title»? Esta acción no se puede deshacer.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get transactionDeleted => 'Movimiento eliminado con éxito';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get csvExportSuccess => 'CSV exportado correctamente';

  @override
  String get budgetOverview => 'Presupuesto mensual';

  @override
  String get createCategoryBudget => 'Crear presupuesto por categoría';

  @override
  String get monthlyLimit => 'Límite mensual';

  @override
  String get limitPlaceholder => 'ej. 500.00';

  @override
  String get spentOf => 'gastado de';

  @override
  String get remaining => 'Restante';

  @override
  String get overBudget => 'Presupuesto excedido';

  @override
  String get setMonthlyLimit => 'Definir límite mensual';

  @override
  String get setBudget => 'Guardar presupuesto';

  @override
  String get categoryBudgets => 'Presupuestos por categoría';

  @override
  String get noCategoryBudgets =>
      'Aún no has creado presupuestos por categoría.';

  @override
  String get spendingBreakdown => 'Distribución de gastos';

  @override
  String get weeklySpendingVelocity => 'Velocidad de gasto semanal';

  @override
  String get noSpendingData => 'Sin gastos registrados en este período';

  @override
  String get highestCategory => 'Mayor categoría';

  @override
  String get financialAnalytics => 'Análisis financiero';

  @override
  String get savingsGoals => 'Metas de ahorro';

  @override
  String get newGoal => 'Nueva meta';

  @override
  String get targetAmount => 'Monto objetivo';

  @override
  String get currentSavings => 'Ahorrado hasta hoy';

  @override
  String get recurringSubscriptions => 'Suscripciones recurrentes';

  @override
  String get newSubscription => 'Añadir suscripción';

  @override
  String get monthlyBurnRate => 'Costo fijo mensual';

  @override
  String get annualBurnRate => 'Costo fijo anual';

  @override
  String get activeSubscriptions => 'Suscripciones activas';

  @override
  String renewsOn(int day) {
    return 'Renueva el día $day del mes';
  }

  @override
  String get settings => 'Ajustes y Privacidad';

  @override
  String get preferences => 'PREFERENCIAS';

  @override
  String get language => 'Idioma';

  @override
  String get languageSubtitle => 'Selecciona tu idioma preferido';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get currency => 'Moneda principal';

  @override
  String get currencySubtitle => 'Moneda de visualización de montos';

  @override
  String get appearance => 'Tema y Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro moderno';

  @override
  String get themeDark => 'Medianoche oscuro';

  @override
  String get themeOled => 'Negro OLED puro';

  @override
  String get dataPortability => 'PORTABILIDAD Y RESPALDO DE DATOS';

  @override
  String get backupData => 'Copia de seguridad (JSON)';

  @override
  String get backupSubtitle => 'Exportar respaldo local completo';

  @override
  String get restoreData => 'Restaurar datos (JSON)';

  @override
  String get restoreSubtitle => 'Importar archivo de respaldo';

  @override
  String get seedSampleData => 'Cargar datos de ejemplo';

  @override
  String get seedSampleSubtitle =>
      'Genera ingresos, gastos y metas para probar';

  @override
  String get sampleDataLoaded => '¡Datos de ejemplo cargados con éxito!';

  @override
  String get security => 'SEGURIDAD Y PRIVACIDAD';

  @override
  String get biometricLock => 'Bloqueo biométrico';

  @override
  String get biometricSubtitle => 'Desbloquea con huella digital o Face ID';

  @override
  String get biometricPrompt => 'Autentícate para acceder a Monetra';

  @override
  String get dataSovereignty => '100% Sin conexión y Privado';

  @override
  String get dataSovereigntySubtitle =>
      'Tus datos financieros residen exclusivamente en tu dispositivo.';

  @override
  String get version => 'Versión';

  @override
  String get catHousing => 'Vivienda y Alquiler';

  @override
  String get catFood => 'Comida y Supermercado';

  @override
  String get catTransport => 'Transporte y Movilidad';

  @override
  String get catShopping => 'Compras y Ropa';

  @override
  String get catEntertainment => 'Entretenimiento y Ocio';

  @override
  String get catHealth => 'Salud y Cuidado Médico';

  @override
  String get catEducation => 'Educación y Formación';

  @override
  String get catTravel => 'Viajes y Vacaciones';

  @override
  String get catBills => 'Facturas y Servicios';

  @override
  String get catSubscriptions => 'Suscripciones';

  @override
  String get catPersonalCare => 'Cuidado Personal';

  @override
  String get catSavingsTransfers => 'Ahorro e Inversión';

  @override
  String get catOtherExpense => 'Otros Gastos';

  @override
  String get catSalary => 'Sueldo y Nómina';

  @override
  String get catFreelance => 'Freelance y Negocios';

  @override
  String get catInvestments => 'Inversiones y Dividendos';

  @override
  String get catGifts => 'Regalos y Devoluciones';

  @override
  String get catOtherIncome => 'Otros Ingresos';

  @override
  String get catOther => 'Otros';

  @override
  String get welcomeTitle => 'Mira tu dinero de forma diferente';

  @override
  String get welcomeSubtitle =>
      'Finanzas personales visuales, inteligentes y 100% privadas.';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get slide1Title => 'Disponible para hoy';

  @override
  String get slide1Desc =>
      'No vuelvas a dudar si puedes pagar una salida. Un presupuesto diario que protege tus facturas y ahorros.';

  @override
  String get slide2Title => 'Claridad visual total';

  @override
  String get slide2Desc =>
      'Anillos de progreso, gráficos interactivos y velocidad de gasto sin hojas de cálculo aburridas.';

  @override
  String get slide3Title => '100% Offline y Soberanía';

  @override
  String get slide3Desc =>
      'Sin claves bancarias. Tus movimientos permanecen encriptados únicamente en tu teléfono.';

  @override
  String get selectCurrencyTitle => 'Selecciona tu moneda principal';

  @override
  String get startExploring => 'Abrir Monetra';

  @override
  String get period7Days => '7 Días';

  @override
  String get period30Days => '30 Días';

  @override
  String get period3Months => '3 Meses';

  @override
  String get periodAllTime => 'Todo el historial';

  @override
  String get period7DaysTitle => 'Velocidad de gasto en 7 días';

  @override
  String get period30DaysTitle => 'Tendencia de gasto en 30 días';

  @override
  String get period3MonthsTitle => 'Comparativa de 3 meses';

  @override
  String get periodAllTimeTitle => 'Evolución mensual del gasto';

  @override
  String get incomeVsExpenses => 'Ingresos vs. Gastos';

  @override
  String get inflow => 'Entradas';

  @override
  String get outflow => 'Salidas';

  @override
  String get netBalance => 'Balance neto';

  @override
  String get spendingDistribution => 'Distribución del gasto';

  @override
  String get categoryBreakdown => 'Desglose por categoría';

  @override
  String get noTransactionsTimeframe => 'No hay transacciones en este período.';

  @override
  String pctOfTotalSpending(String percent) {
    return '$percent% del gasto total';
  }

  @override
  String activeTargetsCount(int count) {
    return 'Metas activas ($count)';
  }

  @override
  String get noSavingsGoals =>
      'Aún no tienes metas de ahorro. ¡Crea una para motivarte!';

  @override
  String targetLabel(String amount) {
    return 'Meta: $amount';
  }

  @override
  String savedLabel(String amount) {
    return 'Ahorrado: $amount';
  }

  @override
  String get addFunds => 'Aportar fondos';

  @override
  String contributeTo(String name) {
    return 'Aportar a «$name»';
  }

  @override
  String get contributionAmount => 'Monto del aporte';

  @override
  String depositedSuccess(String amount, String name) {
    return '¡$amount depositados en $name!';
  }

  @override
  String get createSavingsGoal => 'Crear meta de ahorro';

  @override
  String get goalNameLabel => 'Nombre de la meta (ej. Portátil nuevo)';

  @override
  String get targetAmountLabel => 'Monto objetivo';

  @override
  String get targetDateLabel => 'Fecha estimada';

  @override
  String get createGoal => 'Crear meta';

  @override
  String get monthlyCommitment => 'Compromiso mensual';

  @override
  String get annualProjection => 'Proyección anual';

  @override
  String subscriptionsAndBillsCount(int count) {
    return 'Suscripciones y Facturas ($count)';
  }

  @override
  String get addBill => 'Añadir factura fija';

  @override
  String get noSubscriptionsYet =>
      'Aún no tienes suscripciones periódicas registradas.';

  @override
  String get chooseAppearance => 'Elegir tema';

  @override
  String get restoreBackupTitle => '¿Restaurar copia de seguridad?';

  @override
  String get restoreBackupConfirm =>
      'Restaurar esta copia sustituirá las transacciones, presupuestos y metas actuales. ¿Continuar?';

  @override
  String get restoreDataBtn => 'Restaurar datos';

  @override
  String backupExportError(String error) {
    return 'Error al exportar copia: $error';
  }

  @override
  String get backupInvalidFormat => 'Formato de archivo de Monetra no válido.';

  @override
  String restoreBackupError(String error) {
    return 'Error al restaurar copia: $error';
  }

  @override
  String get biometricsNotAvailable =>
      'Biometría no disponible en este dispositivo';

  @override
  String biometricsFailed(String error) {
    return 'Error en la autenticación biométrica: $error';
  }

  @override
  String get commitmentsUpToDate =>
      '¡Todos los compromisos financieros al día!';

  @override
  String get addSubscriptionTitle => 'Añadir suscripción periódica';

  @override
  String get serviceNameLabel => 'Nombre del servicio (ej. Netflix, Gimnasio)';

  @override
  String get amountPerCycleLabel => 'Importe por período';

  @override
  String get billingFrequencyLabel => 'Frecuencia de cobro';

  @override
  String get billingMonthly => 'Mensual';

  @override
  String get billingWeekly => 'Semanal';

  @override
  String get billingQuarterly => 'Trimestral';

  @override
  String get billingYearly => 'Anual';

  @override
  String get saveSubscription => 'Guardar suscripción';

  @override
  String get skip => 'Saltar';

  @override
  String get next => 'Siguiente';

  @override
  String get txSampleSalary => 'Ingreso de Nómina Mensual';

  @override
  String get txSampleRent => 'Alquiler del Piso';

  @override
  String get txSampleGroceries => 'Compra de Supermercado';

  @override
  String get txSampleTransport => 'Abono de Transporte y Combustible';

  @override
  String get txSampleEntertainment => 'Cine y Cena de Fin de Semana';
}
