# Mobile Shopping App Readme

This mobile application, built using Flutter, allows users to browse and search for products on both iOS and Android platforms. Below are the key features and additional functionalities of the app:

## Key Features

### 1. Home Screen
- Display a list of products with the following information:
  - Product images
  - Product names
  - Ratings
  - Prices (with discounted prices if available)
- Include a search bar that enables users to search for products.
- After a user performs a search, display a list of search results based on their query.

### 2. Product Detail Screen
- Show detailed information about a selected product, including:
  - Product images
  - Category
  - Brand
  - Rating
  - Inventory status
  - Product name
  - Price
  - Description

### 3. Shopping Cart Screen
- Allow users to manage the contents of their shopping cart, including adding and removing products.
- Provide a checkout option for users to complete their purchases.

## Additional Features

### - Handling Loading, Error States, and Lost Internet Connection
- Implement functionality to refresh the data automatically once the internet connection is reestablished after being offline.
- Implement mechanisms to gracefully handle loading states when fetching data.
- Display informative error messages and user-friendly feedback in case of errors during data retrieval.
- Detect and handle situations where the app loses internet connection during data fetching.

### - Pagination
- Implement pagination to retrieve a limited number of records at once when fetching product listings.
- Enhance the app's performance and user experience by efficiently loading data in smaller chunks.

### - Push Notifications
- Integrate push notifications into the app to notify users when a product has been successfully added to their shopping cart.

## Getting Started

To get started with this Flutter-based mobile shopping app, follow these steps:

1. Clone the repository to your local machine.
2. Install Flutter and set up your development environment by following the Flutter installation guide.
3. Navigate to the app's directory and run `flutter pub get` to install the required dependencies.
4. Configure the app to connect to your backend or API if applicable.
5. Run the app on your preferred mobile emulator or device using `flutter run`.

## Dependencies

The following Flutter packages are used in the development of this app along with their versions:

- [flutter_bloc](https://pub.dev/packages/flutter_bloc): ^8.1.3
- [equatable](https://pub.dev/packages/equatable): ^2.0.5
- [http](https://pub.dev/packages/http): ^1.1.0
- [bloc](https://pub.dev/packages/bloc): ^8.1.2
- [stream_transform](https://pub.dev/packages/stream_transform): ^2.1.0
- [bloc_concurrency](https://pub.dev/packages/bloc_concurrency): ^0.2.2
- [animations](https://pub.dev/packages/animations): ^2.0.8
- [connectivity_plus](https://pub.dev/packages/connectivity_plus): ^4.0.2
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications): ^15.1.1

## License

This Flutter-based mobile shopping app is open-source and available under the [MIT License](LICENSE). Feel free to use, modify, and distribute it according to the terms of the license.

## Contact

For questions, feedback, or support related to the app, you can reach out to the project maintainers at [ibrdrahim@gmail.com](mailto:ibrdrahim@gmail.com).

Happy coding!