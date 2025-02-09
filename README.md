# nix-flutter-environment

This repo has a shell.nix to create a development environment for Android.

## You are in the right place if:
- You like Nix and like to have dependencies scoped to a project
    - You like declarative and side-effect free dependencies
- Possibly do not like Android Studio

## Dependencies:
- Have Nix installed

## How to use it:
- copy the shell.nix to the root folder of your Android project

### Use it with nix-shell:
- run `nix-shell`

### Use it with direnv:
- Configure direnv:
    - Have the [direnv](https://direnv.net/docs/installation.html) tool installed
    - Create an .envrc file in your project's root folder `echo "use nix" > .envrc`
    - Run `direnv allow`
- Now everytime you get into the folder the dependencies with be automatically downloaded (if needed) and load into the shell context

## How to validate the developlement environment is working:
- Run the flutter doctor `flutter doctor` to check if all the dependencies are met

## Build a Flutter Android app:
- `flutter build apk` (you may need to run `flutter clean`)

## Run a Flutter Android app in a device:
- Connect the Android device
    - Make sure the developer options is enabled
    - Enable USB debugging
    - Connect the device via USB
- List the devices: `flutter devices`
- Run `flutter run`
