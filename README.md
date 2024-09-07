# flutter_musicapp

Music Quiz App made using Flutter+Firebase.
The project aims to develop a comprehensive mobile application for learning music theory. The app will provide a gamified and interactive environment for users to learn and practice music theory effectively. It is designed as a template for any educational app requiring front-end and back-end services. The app uses Flutter for the front-end and Firebase for back-end services. State management packages such as provider and bloc provider are used for the front end for performance optimisation. The backend services that are mainly used are authentication and Firestore storage. Some metrics that save the user's progress are the courses completed, the stars for each course, and the locked status of each level and course. Performance metrics include an app size of approximately 58 MB, which aligns with the target range of 50-100 MB, and an FPS of about 38. The app aims to achieve a target FPS of 60 for a smooth user experience.

# User Guide

## Prerequisites
Before running the app, ensure you have the following installed:

1. Flutter SDK: Install Flutter and ensure the Flutter command is available in your terminal.
2. VSCode/Android Studio: A preferred code editor with Flutter and Dart plugins.
3. Git: Ensure Git is installed and configured for version control.
4. Firebase CLI: If you use Firebase services (e.g., Firestore), set up Firebase in your project.

## Installation Guide
1. Clone the Repository
  To download the project, open your terminal and run the following:
  ![Screenshot 2024-09-07 143733](https://github.com/user-attachments/assets/d34f8417-7682-4b6f-8cb7-86fa52565f78)
2. Navigate to the Project Directory
   ![Screenshot 2024-09-07 143832](https://github.com/user-attachments/assets/4f175c82-a1dc-45a3-b323-7c8ff3981f87)

3. Install Dependencies
   
  Run the following command to install all the necessary dependencies (listed in pubspec.yaml):
  ![Screenshot 2024-09-07 143843](https://github.com/user-attachments/assets/fe3f5e90-14d3-4485-9ad7-c492c9def57b)

4. Set Up Firebase
  Ensure that the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files are in the appropriate directories:

  Android: Place google-services.json in android/app/.
  iOS: Place GoogleService-Info.plist in ios/Runner/.
  Ensure Firebase is properly set up by following this [link](https://firebase.google.com/docs/flutter/setup?platform=android):

5. Run the App
  Android Emulator: Open Android Studio or your preferred emulator, then run.
  iOS Simulator: Ensure Xcode is installed, then run:

  ![Screenshot 2024-09-07 143910](https://github.com/user-attachments/assets/b87603c1-1e3c-48d9-a4df-d1e865cc5c19)

  If you have multiple devices/emulators, you can specify one using:

  ![Screenshot 2024-09-07 143924](https://github.com/user-attachments/assets/95a0bbbf-e3e7-4597-86a4-0f3bda425f81)

