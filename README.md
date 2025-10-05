# Welcome to SongLib - Desktop

<a href='https://songlib.vercel.app'>
  <img alt='Get it on your Device' src='screenshots/main_banner.png'/>
</a>

 This is the SongLib version for Windows, Linux, MacOS

## Overview

SongLib is tailored for our users who need to sing hymns, designed to streamline their operations and enhance productivity. This Flutter-based application facilitates their access to your church songbook/hymns seamlessly that you don't have to worry about even being online once you have set up the app on your device.
<table>
<tr>
<td><img src="screenshots/Droid/image1.png" width="200px" /></td>
<td><img src="screenshots/Droid/image2.png" width="200px" /></td>
</tr>
</table>

## Getting Started

Follow this guide to set up and run SongLib:

### Setting Up SongLib:

1. **Install Flutter and Dependencies:** Ensure Flutter is installed on your system. Download the Flutter SDK from the official website and set up your preferred IDE (e.g., Android Studio or Visual Studio Code) with the Flutter plugin.

2. **Clone the Repository:** Clone SongLib repository from GitHub using Git:

    ```bash
    git clone git@github.com:SiroDaves/SongLibApp.git
    ```

3. **Install Packages:** Navigate to the project directory and run:

    ```bash
    flutter pub get
    ```

### Running SongLib:

1. **Device Setup:** Connect an emulator or physical device to your development environment. Check connected devices:

    ```bash
    flutter devices
    ```

2. **Update Dependencies:**

    ```bash
    flutter pub get
    ```

3. **Update Code Generated Files:**

    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4. **Update Localization Strings:**

    ```bash
    flutter gen-l10n
    ```
5. **Running SongLib:**
    ```bash
    flutter run --flavor develop -t lib/main_dev.dart --no-tree-shake-icons
    ```

### Building SongLib
  
1. **Windows:**

    ```
    flutter build windows --target=lib/main.dart --no-tree-shake-icons
    ```
          
2. **MacOS:**

    ```
    flutter build macos -t lib/main.dart --no-tree-shake-icons
    ```

    Install create-dmg
    ```
    brew install create-dmg
    ```

    Generate DMG
    ```
    create-dmg \
    --volname "SongLib" \
    --window-pos 200 120 \
    --window-size 800 400 \
    --icon-size 100 \
    --icon "SongLib.app" 200 190 \
    --hide-extension "SongLib.app" \
    --app-drop-link 600 185 \
    "dist/macos/songlib_1.0.799.dmg" \
    "build/macos/Build/Products/Release/SongLib.app"
    ```
         
3. **Linux:**

    Generate the build
    ```
    flutter build linux -t lib/main.dart --no-tree-shake-icons
    ```

    Create a deb package
    ```
    flutter_distributor package --platform linux --targets deb
    ```
    Or an rpm package 
    ```
    flutter_distributor package --platform linux --targets rpm
    ```

Congratulations! You've successfully set up and run or built SongLib. Explore the codebase, make modifications, and contribute to creating a seamless experience for the users. Happy coding!