// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Monetra';

  @override
  String get appTagline => 'Seu dinheiro. Sua visão.';

  @override
  String get appAlternativeTagline =>
      'Veja seu dinheiro de um jeito diferente.';

  @override
  String get navDashboard => 'Início';

  @override
  String get navTransactions => 'Lançamentos';

  @override
  String get navBudgets => 'Orçamentos';

  @override
  String get navAnalytics => 'Análises';

  @override
  String get navGoals => 'Metas';

  @override
  String get safeToSpendToday => 'Livre para gastar hoje';

  @override
  String get dailyAllowanceSubtitle => 'Limite diário disponível calculado';

  @override
  String daysLeftInCycle(int count) {
    return '$count d restantes no ciclo';
  }

  @override
  String get perDay => '/ hoje';

  @override
  String get safeSpendDescription =>
      'Gaste até este valor hoje sem comprometer suas contas fixas nem suas metas de economia.';

  @override
  String get safeSpendExceededDescription =>
      'Limite de orçamento atingido. Reserve os recursos restantes para as contas essenciais.';

  @override
  String get remainingBudget => 'Orçamento restante';

  @override
  String get committedBills => 'Contas fixas';

  @override
  String get projectedEnd => 'Projeção fim do mês';

  @override
  String get monthlyIncome => 'Receitas mensais';

  @override
  String get monthlyExpenses => 'Despesas mensais';

  @override
  String get monthlyBudget => 'Orçamento mensal';

  @override
  String get monthlyBudgetUpper => 'ORÇAMENTO MENSAL';

  @override
  String get onTrack => 'No controle';

  @override
  String get attention => 'Atenção';

  @override
  String get limitExceeded => 'Limite estourado';

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
    return '$amount acima do limite';
  }

  @override
  String get smartInsights => 'ANÁLISES INTELIGENTES';

  @override
  String get insightDailyTargetTitle => 'Meta diária de gastos';

  @override
  String insightDailyTargetMsg(String amount, int days) {
    return 'Manter-se dentro de $amount hoje preserva seu orçamento mensal em equilíbrio para os $days dias restantes.';
  }

  @override
  String get insightBudgetAlertTitle => 'Alerta de orçamento';

  @override
  String get insightBudgetAlertMsg =>
      'Você consumiu mais de 90% do seu orçamento mensal. É recomendável pausar gastos não essenciais para proteger despesas fixas.';

  @override
  String get insightRecurringTitle => 'Compromissos recorrentes';

  @override
  String insightRecurringMsg(String amount) {
    return 'Você possui assinaturas ativas totalizando $amount/mês. Cancelar serviços não utilizados pode gerar economia.';
  }

  @override
  String get insightNetSurplusTitle => 'Superávit positivo';

  @override
  String insightNetSurplusMsg(String amount) {
    return 'Você está economizando $amount este mês. Considere direcionar esse saldo para suas metas de economia.';
  }

  @override
  String get insightSurgeTitle => 'Aumento no ritmo de gastos';

  @override
  String insightSurgeMsg(String category, int percent) {
    return '$category corresponde a $percent% das suas despesas totais no mês.';
  }

  @override
  String get recentActivityUpper => 'ATIVIDADE RECENTE';

  @override
  String get seeAll => 'Ver tudo';

  @override
  String get quickLog => 'Registro rápido';

  @override
  String get noTransactionsYet =>
      'Nenhum lançamento registrado.\nToque no «+» para anotar sua primeira despesa.';

  @override
  String get newTransaction => 'Novo lançamento';

  @override
  String get addExpense => 'Despesa';

  @override
  String get addIncome => 'Receita';

  @override
  String get amount => 'Valor';

  @override
  String get category => 'Categoria';

  @override
  String get selectCategory => 'Selecionar categoria';

  @override
  String get date => 'Data';

  @override
  String get note => 'Observação (opcional)';

  @override
  String get descriptionPayee => 'Descrição / Beneficiário';

  @override
  String get changeDate => 'Alterar';

  @override
  String get saveExpense => 'Salvar despesa';

  @override
  String get saveIncome => 'Salvar receita';

  @override
  String get saveTransaction => 'Salvar';

  @override
  String get enterValidAmount => 'Por favor, digite um valor válido';

  @override
  String get activityHistory => 'Atividade e Histórico';

  @override
  String get searchPlaceholder => 'Buscar por título, nota ou beneficiário...';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterExpenses => 'Despesas';

  @override
  String get filterIncome => 'Receitas';

  @override
  String get allCategories => 'Todas as categorias';

  @override
  String get noTransactionsFound => 'Nenhum lançamento encontrado';

  @override
  String get noTransactionsToExport => 'Nenhum lançamento para exportar';

  @override
  String get deleteTransaction => 'Excluir lançamento?';

  @override
  String confirmDeleteTransaction(String title) {
    return 'Tem certeza de que deseja excluir «$title»? Esta ação não pode ser desfeita.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get transactionDeleted => 'Lançamento excluído com sucesso';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get csvExportSuccess => 'CSV exportado com sucesso';

  @override
  String get budgetOverview => 'Orçamento mensal';

  @override
  String get createCategoryBudget => 'Criar orçamento por categoria';

  @override
  String get monthlyLimit => 'Teto mensal';

  @override
  String get limitPlaceholder => 'ex: 500.00';

  @override
  String get spentOf => 'gastos de';

  @override
  String get remaining => 'Restante';

  @override
  String get overBudget => 'Orçamento estourado';

  @override
  String get setMonthlyLimit => 'Definir teto mensal';

  @override
  String get setBudget => 'Salvar orçamento';

  @override
  String get categoryBudgets => 'Orçamentos por categoria';

  @override
  String get noCategoryBudgets => 'Nenhum orçamento de categoria criado ainda.';

  @override
  String get spendingBreakdown => 'Divisão de despesas';

  @override
  String get weeklySpendingVelocity => 'Velocidade de gastos semanal';

  @override
  String get noSpendingData => 'Nenhuma despesa registrada neste período';

  @override
  String get highestCategory => 'Maior categoria';

  @override
  String get financialAnalytics => 'Análise financeira';

  @override
  String get savingsGoals => 'Metas de economia';

  @override
  String get newGoal => 'Nova meta';

  @override
  String get targetAmount => 'Valor alvo';

  @override
  String get currentSavings => 'Economizado até agora';

  @override
  String get recurringSubscriptions => 'Assinaturas recorrentes';

  @override
  String get newSubscription => 'Adicionar assinatura';

  @override
  String get monthlyBurnRate => 'Custo mensal fixo';

  @override
  String get annualBurnRate => 'Custo anual fixo';

  @override
  String get activeSubscriptions => 'Assinaturas ativas';

  @override
  String renewsOn(int day) {
    return 'Renova no dia $day do mês';
  }

  @override
  String get settings => 'Configurações e Privacidade';

  @override
  String get preferences => 'PREFERÊNCIAS';

  @override
  String get language => 'Idioma';

  @override
  String get languageSubtitle => 'Escolha o idioma de sua preferência';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get currency => 'Moeda principal';

  @override
  String get currencySubtitle => 'Moeda de exibição para todos os valores';

  @override
  String get appearance => 'Tema e Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro moderno';

  @override
  String get themeDark => 'Meia-noite escuro';

  @override
  String get themeOled => 'Preto OLED puro';

  @override
  String get dataPortability => 'PORTABILIDADE E BACKUP DE DADOS';

  @override
  String get backupData => 'Backup do banco (JSON)';

  @override
  String get backupSubtitle => 'Exportar backup local completo';

  @override
  String get restoreData => 'Restaurar banco (JSON)';

  @override
  String get restoreSubtitle => 'Importar arquivo de backup';

  @override
  String get seedSampleData => 'Carregar dados de exemplo';

  @override
  String get seedSampleSubtitle => 'Gera receitas, despesas e metas para teste';

  @override
  String get sampleDataLoaded => 'Dados de exemplo carregados com sucesso!';

  @override
  String get security => 'SEGURANÇA E PRIVACIDADE';

  @override
  String get biometricLock => 'Bloqueio biométrico';

  @override
  String get biometricSubtitle => 'Desbloqueie com biometria ou Face ID';

  @override
  String get biometricPrompt => 'Autentique-se para abrir o Monetra';

  @override
  String get dataSovereignty => '100% Offline e Privado';

  @override
  String get dataSovereigntySubtitle =>
      'Seus dados financeiros ficam exclusivamente no seu aparelho.';

  @override
  String get version => 'Versão';

  @override
  String get catHousing => 'Moradia e Aluguel';

  @override
  String get catFood => 'Alimentação e Mercado';

  @override
  String get catTransport => 'Transporte e Combustível';

  @override
  String get catShopping => 'Compras e Roupas';

  @override
  String get catEntertainment => 'Lazer e Entretenimento';

  @override
  String get catHealth => 'Saúde e Medicamentos';

  @override
  String get catEducation => 'Educação e Cursos';

  @override
  String get catTravel => 'Viagens e Férias';

  @override
  String get catBills => 'Contas e Serviços';

  @override
  String get catSubscriptions => 'Assinaturas';

  @override
  String get catPersonalCare => 'Cuidados Pessoais';

  @override
  String get catSavingsTransfers => 'Poupança e Investimentos';

  @override
  String get catOtherExpense => 'Outras Despesas';

  @override
  String get catSalary => 'Salário e Proventos';

  @override
  String get catFreelance => 'Freelance e Negócios';

  @override
  String get catInvestments => 'Investimentos e Dividendos';

  @override
  String get catGifts => 'Presentes e Reembolsos';

  @override
  String get catOtherIncome => 'Outras Receitas';

  @override
  String get catOther => 'Outro';

  @override
  String get welcomeTitle => 'Veja seu dinheiro de um jeito diferente';

  @override
  String get welcomeSubtitle =>
      'Finanças pessoais visuais, inteligentes e 100% privadas.';

  @override
  String get getStarted => 'Começar';

  @override
  String get slide1Title => 'Livre para gastar hoje';

  @override
  String get slide1Desc =>
      'Nunca mais se pergunte se pode pedir uma pizza. Um orçamento diário calculado que protege suas contas.';

  @override
  String get slide2Title => 'Zero confusão, clareza total';

  @override
  String get slide2Desc =>
      'Anéis de progresso, gráficos interativos e velocidade de gastos sem planilhas complexas.';

  @override
  String get slide3Title => '100% Offline e Soberania';

  @override
  String get slide3Desc =>
      'Sem senhas bancárias. Seus registros financeiros ficam criptografados apenas no seu smartphone.';

  @override
  String get selectCurrencyTitle => 'Selecione sua moeda principal';

  @override
  String get startExploring => 'Abrir o Monetra';

  @override
  String get period7Days => '7 Dias';

  @override
  String get period30Days => '30 Dias';

  @override
  String get period3Months => '3 Meses';

  @override
  String get periodAllTime => 'Todo o histórico';

  @override
  String get period7DaysTitle => 'Velocidade de gastos em 7 dias';

  @override
  String get period30DaysTitle => 'Tendência de gastos em 30 dias';

  @override
  String get period3MonthsTitle => 'Comparação de 3 meses';

  @override
  String get periodAllTimeTitle => 'Evolução mensal dos gastos';

  @override
  String get incomeVsExpenses => 'Receitas vs. Despesas';

  @override
  String get inflow => 'Entradas';

  @override
  String get outflow => 'Saídas';

  @override
  String get netBalance => 'Saldo líquido';

  @override
  String get spendingDistribution => 'Distribuição de gastos';

  @override
  String get categoryBreakdown => 'Detalhamento por categoria';

  @override
  String get noTransactionsTimeframe => 'Nenhuma transação neste período.';

  @override
  String pctOfTotalSpending(String percent) {
    return '$percent% do gasto total';
  }

  @override
  String activeTargetsCount(int count) {
    return 'Metas ativas ($count)';
  }

  @override
  String get noSavingsGoals =>
      'Nenhuma meta de economia ainda. Crie uma para manter o foco!';

  @override
  String targetLabel(String amount) {
    return 'Meta: $amount';
  }

  @override
  String savedLabel(String amount) {
    return 'Economizado: $amount';
  }

  @override
  String get addFunds => 'Depositar';

  @override
  String contributeTo(String name) {
    return 'Depositar em «$name»';
  }

  @override
  String get contributionAmount => 'Valor do depósito';

  @override
  String depositedSuccess(String amount, String name) {
    return '$amount adicionados a $name!';
  }

  @override
  String get createSavingsGoal => 'Criar meta de economia';

  @override
  String get goalNameLabel => 'Nome da meta (ex. Notebook novo)';

  @override
  String get targetAmountLabel => 'Valor alvo';

  @override
  String get targetDateLabel => 'Data alvo';

  @override
  String get createGoal => 'Salvar meta';

  @override
  String get monthlyCommitment => 'Compromisso mensal';

  @override
  String get annualProjection => 'Projeção anual';

  @override
  String subscriptionsAndBillsCount(int count) {
    return 'Assinaturas e Contas ($count)';
  }

  @override
  String get addBill => 'Adicionar conta fixa';

  @override
  String get noSubscriptionsYet => 'Nenhuma assinatura recorrente cadastrada.';

  @override
  String get chooseAppearance => 'Escolher Tema';

  @override
  String get restoreBackupTitle => 'Restaurar Backup?';

  @override
  String get restoreBackupConfirm =>
      'Restaurar este backup substituirá as transações, orçamentos e metas atuais. Prosseguir?';

  @override
  String get restoreDataBtn => 'Restaurar Dados';

  @override
  String backupExportError(String error) {
    return 'Erro ao exportar backup: $error';
  }

  @override
  String get backupInvalidFormat => 'Formato de arquivo de backup inválido.';

  @override
  String restoreBackupError(String error) {
    return 'Erro ao restaurar backup: $error';
  }

  @override
  String get biometricsNotAvailable =>
      'Biometria não disponível neste dispositivo';

  @override
  String biometricsFailed(String error) {
    return 'Falha na autenticação biométrica: $error';
  }

  @override
  String get commitmentsUpToDate => 'Todos os compromissos financeiros em dia!';

  @override
  String get addSubscriptionTitle => 'Adicionar Assinatura / Conta Recorrente';

  @override
  String get serviceNameLabel => 'Nome do serviço (ex. Netflix, Academia)';

  @override
  String get amountPerCycleLabel => 'Valor por ciclo';

  @override
  String get billingFrequencyLabel => 'Periodicidade de cobrança';

  @override
  String get billingMonthly => 'Mensal';

  @override
  String get billingWeekly => 'Semanal';

  @override
  String get billingQuarterly => 'Trimestral';

  @override
  String get billingYearly => 'Anual';

  @override
  String get saveSubscription => 'Salvar Assinatura';

  @override
  String get skip => 'Pular';

  @override
  String get next => 'Avançar';

  @override
  String get txSampleSalary => 'Depósito de Salário Mensal';

  @override
  String get txSampleRent => 'Aluguel Residencial';

  @override
  String get txSampleGroceries => 'Compras do Mês no Mercado';

  @override
  String get txSampleTransport => 'Passe de Ônibus / Metrô e Gasolina';

  @override
  String get txSampleEntertainment => 'Cinema e Jantar no Fim de Semana';
}
