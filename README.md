# fanpage

This app was developed for iOS and Android using Android Studio and implements use of the API firebase.

## Getting Started

Resources used in guiding the development of this project:
- [FlutterFire Overview](https://firebase.flutter.dev/docs/overview/)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)

# Guidelines
To create and publish an app on two of the following platforms: iOS, Android, Web
Create a Splash Screen
Integrate the Firebase API into your mobile application
Set up User Registration and User Login pages
Assign Admin to 1 User
Admin should be able to post messages
Users should be able to view messages

## Firebase & Cloud Firestore
- Cloud Firestore stores unique user id, user first name, user last name,
user role ( defaults to customer ), and registration datetime
- Firebase Authentication should be able to accept email and password, and at
least one social media login
- Users who are not adminis will not be able to post any messages but can view them


# Dependencies and Plugins
## Google and Firebase:
Inside 'build.gradle' file under the 'android/app' folder, add these implementations in the 'dependencies {}' section:

implementation platform('com.google.firebase:firebase-bom:28.1.0')
implementation 'com.google.firebase:firebase-analytics-ktx'
implementation 'com.android.support:multidex:1.0.3'
implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"


Inside 'build.gradle' file that is inside the 'android' folder, add these implementations in the 'dependencies {}' section:

classpath 'com.android.tools.build:gradle:4.1.0'
classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
classpath 'com.google.gms:google-services:4.3.8'


## pubspec.yaml:
flutter sdk version 
sdk: ">=2.12.0 <3.0.0"

firebase_core: ^1.3.0
firebase_auth: ^1.4.1
cloud_firestore: ^2.2.2
google_sign_in: "^4.5.1"
flutter_signin_button: ^2.0.0 
