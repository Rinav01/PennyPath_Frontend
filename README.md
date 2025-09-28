# PennyPath

A personal expense tracking application built with Flutter. PennyPath helps you to manage your finances by tracking your income and expenses, and providing insights into your spending habits.

## Description

PennyPath is a mobile application for Android and iOS that allows you to track your expenses and income. It is designed to be simple and intuitive, so you can easily add new transactions and see where your money is going. With PennyPath, you can categorize your transactions, set budgets, and view detailed reports and charts to understand your spending patterns.

This application is perfect for anyone who wants to take control of their finances and make better financial decisions. Whether you are a student, a young professional, or a family, PennyPath can help you to stay on top of your finances and achieve your financial goals.

## Features

*   **User Authentication:** Securely sign up, log in, and recover your password if you forget it. Your financial data is protected and only accessible to you.
*   **Expense and Income Tracking:** Quickly add new transactions, including the amount, date, category, and a description. You can also mark transactions as an expense or an income.
*   **Categorization:** Create and manage your own categories for your transactions. You can assign a name and a color to each category to easily identify them.
*   **Budgeting:** Set monthly budgets for different categories to control your spending and avoid overspending.
*   **Reports and Charts:** Visualize your financial data with interactive charts and detailed reports. You can see your spending by category, your income vs. expenses, and your progress towards your financial goals.
*   **Cross-platform:** PennyPath is available for both Android and iOS, so you can use it on all your devices.

## User Experience

### Splash Screen

A beautiful splash screen that welcomes the user to the application. It is implemented using a Lottie animation and is displayed for a few seconds before the main application is loaded.

### Authentication Flow

A new authentication flow has been introduced. On the first launch of the application, the user is presented with a sign-up screen. On subsequent launches, the user is presented with a login screen. This is handled by the `AuthWrapper` widget, which checks for a `isFirstLaunch` flag in `shared_preferences`.

### First Launch Experience

On the first launch of the application, the user is presented with a sign-up screen. This is to encourage new users to create an account and start using the application. The sign-up screen is similar to the login screen, but with a "Sign Up" button instead of a "Sign In" button. After the user signs up, the `isFirstLaunch` flag is set to `false` in `shared_preferences`, so that on subsequent launches the user is presented with the login screen.

### Loading Animations

Engaging Lottie animations are displayed while data is being fetched from the backend, improving the user experience. This is implemented in the `main_screen.dart` file, where the `isLoading` flag from the `ExpenseProvider` is used to show or hide the animation. This provides a visual feedback to the user that the application is busy loading data.

## Getting Started

### Prerequisites

*   Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   An emulator or a physical device to run the app.

### Installation

1.  Clone the repository:
    ```sh
    git clone https://github.com/your-username/pennypath.git
    ```
2.  Install dependencies:
    ```sh
    flutter pub get
    ```
3.  Run the app:
    ```sh
    flutter run
    ```

## Folder Structure

```
.
├── android
├── assets
├── build
├── ios
├── lib
│   ├── app.dart
│   ├── app_view.dart
│   ├── auth_wrapper.dart
│   ├── main.dart
│   ├── models
│   │   └── models.dart
│   ├── providers
│   │   ├── auth_provider.dart
│   │   ├── category_provider.dart
│   │   └── expense_provider.dart
│   ├── screens
│   │   ├── add_expense
│   │   ├── home
│   │   ├── login
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   ├── splash_screen.dart
│   │   └── stats
│   └── services
│       └── api_service.dart
├── linux
├── macos
├── test
├── web
└── windows
```

*   `lib`: Contains the core application code.
    *   `main.dart`: The entry point of the application. It initializes the app and the state management providers.
    *   `app.dart` & `app_view.dart`: The root of the application, which handles the main UI and navigation.
    *   `auth_wrapper.dart`: A widget that wraps the main application and checks the authentication state of the user.
    *   `models`: Contains the data models for the application, such as `Expense`, `Category`, and `User`.
    *   `providers`: Contains the state management logic for the application using the `provider` package.
        *   `auth_provider.dart`: Manages the user authentication state.
        *   `category_provider.dart`: Manages the categories.
        *   `expense_provider.dart`: Manages the expenses.
    *   `screens`: Contains the different screens of the application, such as the login screen, home screen, and add expense screen.
        *   `splash_screen.dart`: A splash screen that is displayed when the application is launched.
    *   `services`: Contains the business logic for the application, such as API calls to a backend service.
        *   `api_service.dart`: A service class that handles all the communication with the backend API.
*   `assets`: Contains the static assets for the application, such as images and fonts.
*   `test`: Contains the tests for the application.
*   The other directories are platform-specific code for Android, iOS, Linux, macOS, web, and Windows.

## State Management

This project uses the `provider` package for state management. It is a simple and powerful way to manage the state of the application. The `AuthProvider`, `CategoryProvider`, and `ExpenseProvider` classes are used to manage the state of the user authentication, categories, and expenses, respectively.

## API Service

The application interacts with a backend service to store and retrieve data. The `ApiService` class in the `lib/services/api_service.dart` file is responsible for making HTTP requests to the backend API. It uses the `http` package to make the requests.

## Screenshots

**New Login Screen**

*(Add a screenshot of the new login screen here)*

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.