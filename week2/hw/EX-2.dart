class BankAccount {
  final String _bank_id;
  final String _fullname;
  final DateTime _created_at = DateTime.now();
  late double _balance = 0;

  BankAccount({required this._bank_id, required this._fullname});

  double get getBalance => this._balance;
  String get getFullname => this._fullname;
  DateTime get getCreated_date => this._created_at;
  String get getBankID => this._bank_id;

  double withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Withdrawal amount must be positive');
    }
    if (amount > this._balance) {
      throw ArgumentError('Insufficient Balance');
    }
    this._balance -= amount;
    return this._balance;
  }

  double credit(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Credit amount must be positive');
    }

    this._balance += amount;
    return this._balance;
  }

  void printDetail() {
    print('==========================');
    print('AccountID: $_bank_id');
    print('Name: $_fullname');
    print('Balance: \$$_balance');
    print('Created At: $_created_at');
    print('==========================');
  }
}

// Validation Class
class Validate {
  Validate({
    required List<BankAccount> bank_accounts,
    required BankAccount account,
  }) {
    if (account._balance < 0) throw new ArgumentError("Insufficient Balance");
    for (var b in bank_accounts) {
      if (account._bank_id == b._bank_id)
        throw new ArgumentError('Exisiting Acoount with ID ${b.getBankID}');
    }
  }
}

class Bank {
  late String _bankName;
  late List<BankAccount> _bank_accounts = [];
  Bank({required this._bankName});

  List<BankAccount> get getAccountLists => this._bank_accounts;
  String get getBankName => this._bankName;

  BankAccount createAccount(String bank_id, String username) {
    BankAccount account = BankAccount(bank_id: bank_id, fullname: username);
    Validate(bank_accounts: _bank_accounts, account: account);
    _bank_accounts.add(account);
    return account;
  }
}

void main() {
  Bank bank = Bank(bankName: "CADT BANK");
  BankAccount user = bank.createAccount('A01', 'Ronan');
  BankAccount user2 = bank.createAccount('A01', 'Kira Hong');

  user.printDetail();
  user.credit(10);
  user.withdraw(8);
  user.printDetail();

  user2.printDetail();
  user2.credit(10);
  user2.withdraw(8);
  user2.printDetail();

  // Bank myBank = Bank(name: "CADT Bank");
  // BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  // print(ronanAccount.balance); // Balance: $0
  // ronanAccount.credit(100);
  // print(ronanAccount.balance); // Balance: $100
  // ronanAccount.withdraw(50);
  // print(ronanAccount.balance); // Balance: $50

  // try {
  //   ronanAccount.withdraw(75); // This will throw an exception
  // } catch (e) {
  //   print(e); // Output: Insufficient balance for withdrawal!
  // }

  // try {
  //   myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  // } catch (e) {
  //   print(e); // Output: Account with ID 100 already exists!
  // }
}
