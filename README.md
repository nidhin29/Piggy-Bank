# Piggy Bank

A comprehensive Flutter-based personal finance management application that helps users track their income and expenses efficiently. The app features a clean, modern UI with robust local data storage using Hive database.

## 🚀 Features

### Core Functionality
- **Transaction Management**: Add, view, and delete financial transactions
- **Category Management**: Create custom income and expense categories
- **Real-time Data**: Live updates using ValueNotifier for reactive UI
- **Local Storage**: Persistent data storage using Hive database

### User Interface
- **Bottom Navigation**: Easy switching between transactions and categories
- **Tab View**: Separate views for income and expense categories
- **Date Picker**: Built-in date selection for transactions
- **Dropdown Selection**: Category selection with filtered options
- **Material Design**: Clean, intuitive interface following Material Design principles

### Data Features
- **Transaction Tracking**: Record purpose, amount, date, and category for each transaction
- **Category Types**: Separate income and expense categories
- **Data Persistence**: All data stored locally using Hive
- **Auto-generated IDs**: Unique identifiers for all records
- **Date Formatting**: User-friendly date display using intl package

### Architecture
- **Model-View Pattern**: Clean separation of data models and UI
- **Singleton Pattern**: Database instances using singleton pattern
- **Repository Pattern**: Abstract database functions with concrete implementations
- **State Management**: ValueNotifier for reactive state management

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point with splash screen
├── home1.dart               # Main navigation and bottom bar
├── home.dart                # Transaction list view
├── category.dart            # Category management with tabs
├── income.dart              # Income category display
├── expense.dart             # Expense category display
├── category_db.dart         # Category data models
├── transactions_db.dart     # Transaction data models
├── db/
│   └── category/
│       ├── category_db1.dart        # Category database operations
│       ├── category_popup.dart      # Add category form
│       ├── transaction_popup.dart   # Add transaction form
│       └── transactions/
│           └── transaction_db1.dart # Transaction database operations
└── asset/
    └── image/               # App images and icons
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=2.19.6 <3.0.0)
- Dart SDK
- Android Studio / VS Code
- Device emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd money_manager_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS IPA:**
```bash
flutter build ios --release
```

**Windows Executable:**
```bash
flutter build windows --release
```

## 🔧 Configuration

### Database
The app uses Hive for local storage with three main collections:
- Categories (TypeId: 1)
- Category Types (TypeId: 2)
- Transactions (TypeId: 3)

### Assets
Add images to `lib/asset/image/` and configure in `pubspec.yaml`

## 📝 Usage

1. **Launch the app** - View animated splash screen
2. **View transactions** - See all your financial records on the home screen
3. **Add transactions** - Tap the floating action button on the transaction tab
4. **Manage categories** - Switch to category tab to view/add income and expense categories
5. **Add categories** - Tap the floating action button on the category tab

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

For support or questions, please open an issue in the repository.

---

**Piggy Bank** - Take control of your finances with style! 💰
