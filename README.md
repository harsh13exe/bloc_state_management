# Grocery App - Flutter BLoC State Management Demo

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/State%20Management-BLoC-blueviolet.svg)](https://bloclibrary.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Project Status](https://img.shields.io/badge/status-demo-green.svg)]()

This is a sample Flutter application demonstrating robust state management using the **BLoC (Business Logic Component)** pattern. It's a simple grocery shopping app where users can browse products, add them to a cart, and save them to a wishlist.

The primary goal of this project is to showcase a clean, scalable, and testable architecture by separating business logic from the UI. It serves as a practical example for anyone looking to understand and implement BLoC in a Flutter project.

## ✨ App Demo
<img width="400" height="800" alt="Screenshot_1761401583" src="https://github.com/user-attachments/assets/946a0e2f-37f5-4cf9-bcce-5df255c32001" />


## 🚀 Features

* **Product Listing:** Fetches and displays a list of grocery products.
* **Wishlist:** Add or remove items from a persistent wishlist.
* **Cart:** Add items to a persistent shopping cart.
* **Navigation:** Seamlessly navigate between the Home, Wishlist, and Cart pages.
* **Real-time Feedback:** Uses `SnackBar`s to notify the user when an item is added to the cart or wishlist.
* **Asynchronous Handling:** Displays a loading indicator while fetching initial data.

## 🏛️ Architecture: BLoC

This project is built using the **BLoC** pattern, which helps in managing state and business logic.

* **UI (Presentation Layer):** The Flutter widgets, which are only responsible for rendering the UI and dispatching events to the BLoCs.
* **BLoC (Business Logic Layer):** The `HomeBloc`, `WishlistBloc`, and `CartBloc` listen to events, process business logic, and emit states.
* **Data Layer:** Mock data (`GroceryData`, `cartItems`, `wishlistItems`) is used to simulate a backend or database.

## 💡 Key BLoC Concepts Demonstrated

This project is a great example of several powerful BLoC patterns:

1.  **Events:** User interactions are sent to the BLoC as plain Dart objects.
    * `HomeProductWishlistButtonClickedEvent`
    * `HomeCartButtonNavigateEvent`
    * `WishlistRemoveFromWishlistEvent` (and so on...)

2.  **States:** The BLoC emits different states that the UI listens to.

3.  **Action States vs. Build States:** This is a crucial pattern used in the app.
    * **Build States** (like `HomeLoadingState`, `HomeLoadedSuccessState`): These tell the UI *what* to build. The `builder` in `BlocConsumer` listens to these.
    * **Action States** (like `HomeNavigateToCartPageActionState`, `HomeProductItemWishlistedActionState`): These are one-time events that tell the UI to *do* something (like navigate or show a SnackBar). The `listener` in `BlocConsumer` listens for these, preventing unnecessary UI rebuilds.

4.  **`BlocConsumer`:** This widget is used perfectly in `Home.dart` to separate rebuilding the UI (with `buildWhen`) from handling side effects (with `listenWhen`).

5.  **State Management Across Screens:** By using global lists (`cartItems`, `wishlistItems`) managed by the BLoCs, the state is preserved when navigating between different screens.

## 📁 Project Structure

The project follows a clean, feature-first directory structure.

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/your-username/bloc_state_management.git](https://github.com/your-username/bloc_state_management.git)
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd bloc_state_management
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the app:**
    ```sh
    flutter run
    ```

## 📈 Future Improvements

This demo can be extended with more advanced features:

* **Dependency Injection:** Replace passing BLoC instances in constructors with `BlocProvider` to provide BLoCs via the widget tree.
* **Repository Pattern:** Introduce a `Repository` layer to abstract the data source.
* **Real Backend:** Replace the mock data lists with a real backend like Firebase Firestore or a REST API.
* **Testing:** Write unit tests for the BLoCs and widget tests for the UI.
* **Persistence:** Use `shared_preferences` or `hive` to save the cart and wishlist even after the app is closed.
