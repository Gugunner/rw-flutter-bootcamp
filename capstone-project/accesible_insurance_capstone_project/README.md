# Project Capstone Building a Tech Demo of Flutter

This is a project capstone as a tech demo developed during Raywenderlichs Flutter Accelerator Camp 2022.
___
### How to read this project.

The main README file is all about understanding the scope and the "why" of the tech demo, here you'll find information about what problem is the
tech demo trying to solve and how it addresses the problem. You'll also find information on the app architecture and main packages used. 

For detailed information on implementation the README updates each developing stage in a diferent .md file for reference, the decision to work the document in this fashion was made because the capstone project needs to be worked during the weeks of the bootcamp and each week some challenges arise to continue developing. The idea is to make clear on how each problem was tackled and the way it was solved, this includes code snippets and gifs of app behavior for reference on what is accomplished.

This document and demo in any way or form is trying to convey how a Flutter app should be developed but more as a reference point on how the demo uses different tools and techniques to obtain a final result, please enjoy and feel free to contact me with any detail on inquiry at ram2489@gmail.com. 
___
### Why do it?

More than 35 million inhabitants of LATAM are constantly moving to other countries in search of better opportunities, but many times they leave behind family members. Sadly sometimes disasters occur and there is no backup plan.

### What it is trying to solve?
An app that allows low to median-income households to obtain property and life insurance with flexible micropayments as either full attractive insurance policies or a side saving scheme for unpredictable events.

### How does it work?
It allows any person easy access to acquire an insurance policy for her or another family member. The user can start by paying a minimum entrance fee and by using flexible micro payment options increase the sum insured. Each payment creates a new sub-policy and extends the insurance for a whole year. This allows people with variant income to secure what is important to them without locked complex payment agreements. 

___

## App Dependencies

The app uses the following packages (if more are added this document will be updated):

```
dependencies:
- flutter:
  - sdk: flutter
  - flutter_riverpod: ^2.0.0-dev.9 (State manager)
  - cupertino_icons: ^1.0.2 (By default if an iOS project)
  - firebase_core: ^1.22.0 (Allows using Firebase)
  - firebase_auth: ^3.8.0 (Auth)
  - cloud_firestore: ^3.4.7 (DB)
  - freezed_annotation: ^2.1.0 (Needed by Freezed)
  - json_annotation: ^4.6.0 (Needed by Freezed)
  - go_router: ^5.1.3 (Simplified Navigation 2.0)
  - get_it: ^7.2.0 (State manager without the need of BuildContext)
  - shared_preferences: ^2.0.15 (Persistent storage for basic values)
  - flutter_svg: ^1.1.5 (Handles SVG assets)
  - sqflite: ^2.1.0+1 (Manages App SQLite DB) 
  - path_provider: ^2.0.11 (Easy access device directories)
  - synchronized: ^3.0.0+3 (Keeps data in sync)
  - sqlbrite: ^2.4.0 (Easily manage SQL DB)
  - path: ^1.8.2 (Access specific paths)
  - equatable: ^2.0.5 (Easily convert model properties to compare them)
  - intl: ^0.17.0 (Manage international formats)
  - google_sign_in: ^5.4.2 (Google SSO)
  - firebase_storage: ^11.0.3 (Manage Firebase Api)
  - image_picker: ^0.8.6 (Helps open device image selection)


dev_dependencies:
  - flutter_test:
    - sdk: flutter
  - flutter_lints: ^2.0.0
  - build_runner: ^2.2.1 (Needed by Freezed and other packages)
  - freezed: ^2.1.0+1 (Build safe non mutable models)
  - json_serializable: ^6.3.2 (Allows parsing from/to json easily)
  - firebase_auth_mocks: ^0.9.0 (Mocks the Auth Api)
  - google_sign_in_mocks: ^2.0.1 (Mocks Google SSO)
  - fake_cloud_firestore: ^2.0.1 (Create a local fake Firestore for testing)
  - flutter_launcher_icons: ^0.10.0 (Helps easily create app icons for flutter platforms)
```

## App Screens

Due to the limited time to build the capstone project the scope of the app is also constrained, here are the screens that will be developed for the tech demo.

<br>
<img src="assets/app_screens_scope.png" width="340" height="420" /> 

Each line arrow represents the navigation of the app some screens can return back while others can't.

## App Architecture and Structure

The app has a Feature-first approach for all the directories in root and inside each "feature" folder the sub directories are structured as data (containes repositories, apis and services); domain (contains providers and models); ui (contains widgets and screens) and finally utils (contains possible controllers and other files).

Here is an example of the directory

```
|-lib/
|--master_policy/
|---data/
|---repository/
|----abstract_repository.dart
|----real_repository.dart
|----fake_repository.dart
|---api/
|----master_policy_api.dart
|---domain/
|----model/
|-----master_policy_model.dart
|----provider
|-----master_policy_provider.dart
|---ui
|----widgets/
|-----master_policy_card.dart
|-----insurance_type.dart
|----master_policy_screen.dart
|---utils/
|----insurance_types.dart

```
Note that the app follows a repository pattern and MVVM pattern for the app, while some MVC implementations may occur, the main focus is to keep data flow going from Data, Domain, Application and finally Presentation and backwards in the same pattern.

### First deliverable

The first deliverable is focused on testing riverpod and connecting SIGN IN with MASTER POLICIES screens.

Check the progress in [WEEK 6](/capstone-project/accesible_insurance_capstone_project/WEEK6.md).

### Second deliverable 

The second deliverable is focused on integrating Firebase Authentication and Firestore, this includes a sign in with a predefined account and retrieving a mocked policy document with some basic fields.

Check the progress in [WEEK 7](/capstone-project/accesible_insurance_capstone_project/WEEK7.md).

### Third deliverable 

The third deliverable is focused on adding some unit tests and some widget tests for the SignInScreen, it also focuses on code coverage and reports and finally creates an onboarding process with some GoRouter custom transition implementations. 

Check the progress in [WEEK 8](/capstone-project/accesible_insurance_capstone_project/WEEK8.md).

### Fourth deliverable 

The fourth deliverable is focused on basic animations for the app using implicit and explicit animations. It also makes some changes by using subroutes before implementing child policies inside the app. 

Check the progress in [WEEK 9](/capstone-project/accesible_insurance_capstone_project/WEEK9.md).


### Fifth deliverable

The fifth deliverable is focused on data persistence by using a simple storage solution such as SharedPreferences and a more complex and robust one with SQLite using SQFlite and SQLBrite.

Check the progress in [WEEK 10](/capstone-project/accesible_insurance_capstone_project/WEEK10.md).

### Sixth deliverable 

The sixth deliverable targets the use of Firebase integration which includes Firebase Auth, Firebase Firestore basic CRUD operations and Firebase Cloud Storage.

Check the progress in [WEEK 11](/capstone-project/accesible_insurance_capstone_project/WEEK11.md). 

### Seventh and final deliverable of Bootcamp

The seventh deliverable targets creating a cohesive app concept that uses all the homeworks from the capstone project to create a user flow of the acquisition of master policies. In this deliverable the main focus was fixing bugs of state management and improve UI style and theme.
Check the progress in [WEEK 12](/capstone-project/accesible_insurance_capstone_project/WEEK11.md). 

