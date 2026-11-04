import '../../l10n/generated/app_localizations.dart';

String getLocalizedTxTitle(String title, AppLocalizations? l10n) {
  if (l10n == null) return title;
  switch (title) {
    case 'Monthly Salary Deposit':
      return l10n.txSampleSalary;
    case 'Apartment Rent':
      return l10n.txSampleRent;
    case 'Whole Foods Market':
      return l10n.txSampleGroceries;
    case 'Food & Groceries Market':
      return l10n.txSampleGroceries;
    case 'Metro Pass & Fuel':
      return l10n.txSampleTransport;
    case 'Weekend Cinema & Dinner':
      return l10n.txSampleEntertainment;
    case 'Expense':
      return l10n.addExpense;
    case 'Income':
      return l10n.addIncome;
    case 'Freelance & Business':
      return l10n.catFreelance;
    case 'Housing & Rent':
      return l10n.catHousing;
    case 'Food & Groceries':
      return l10n.catFood;
    case 'Transportation':
      return l10n.catTransport;
    case 'Entertainment':
      return l10n.catEntertainment;
    case 'Shopping':
      return l10n.catShopping;
    case 'Health & Medical':
      return l10n.catHealth;
    case 'Education':
      return l10n.catEducation;
    case 'Travel & Vacation':
      return l10n.catTravel;
    case 'Utilities & Bills':
      return l10n.catBills;
    case 'Subscriptions':
      return l10n.catSubscriptions;
    case 'Personal Care':
      return l10n.catPersonalCare;
    case 'Savings Transfer':
      return l10n.catSavingsTransfers;
    case 'Other Expense':
      return l10n.catOtherExpense;
    case 'Salary':
      return l10n.catSalary;
    case 'Investments & Dividends':
      return l10n.catInvestments;
    case 'Gifts & Grants':
      return l10n.catGifts;
    case 'Other Income':
      return l10n.catOtherIncome;
    case 'Other':
      return l10n.catOther;
    default:
      return title;
  }
}
