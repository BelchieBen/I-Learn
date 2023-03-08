# I-Learn
This repository contains the source code for my ITEC27003 coursework. The app is a booking style app for Ideagen's internal training programme.

# Features
The current list of feature is:
- User authentication and signup
- Browsing popular and recomended courses added by admins
- Searching for specific courses using free text search, pre-defined filters and sort filters
- Submit a booking request for a specific course session
- Rescheduling that booking to choose a different date
- Cancelling the booking
- Registering your attendance to a specific session through scanning QR codes
- A user profile page

All features are fully implemented, acompanied with reactive UI components. 

The app also uses Supabase for a backend. 

## Getting Started

If you want to setup a local development copy of the application then do the following:
- Clone the master branch onto your computer
- Open a terminal and run `flutter pub get` to resolve the dependencies
> NOTE this app was developed using Flutter v3.7.3 and using the new useMaterial3 Theme flag.
- In a that terminal run `flutter run` and chose to run on either an Android emulator or your Android device

# Using App Builds

After every feature I automatically build and release the app, to download one of these releases head to the *Releases* section in the repository and download the latest apk.
> NOTE this is a debug apk and you will have to manually allow it to be installed as it is not a Google Play certified app.

Current there are no IOS builds or releases as I do not have access to a mac (A requirements by Apple to build and run IOS aps)
