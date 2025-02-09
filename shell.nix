{ pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
} }:
let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "26.1.1";
    platformToolsVersion = "35.0.1";
    buildToolsVersions = [
      "30.0.3"
      "33.0.1"
      "34.0.0"
    ];
    platformVersions = [
      "31"
      "33"
      "34"
    ];
    abiVersions = [ "x86_64" ];
    includeEmulator = true;
    emulatorVersion = "35.1.4";
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    includeSources = false;
    extraLicenses = [
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };
  androidSdk = androidComposition.androidsdk;
  buildToolsVersion = "33.0.1";
in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    clang
    cmake
    ninja
    pkg-config

    gtk3

    flutter
    androidSdk
    # android-studio
    jdk17
    firebase-tools

    chromium
  ];

  LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
    fontconfig.lib
    sqlite.out
  ];

  GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/gtk+3-3.24.41/glib-2.0/schemas/";

  shellHook = ''
    export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk";
    export ANDROID_HOME="${androidSdk}/libexec/android-sdk";
    export JAVA_HOME="${pkgs.jdk17}";
    export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";

    export CHROME_EXECUTABLE="${pkgs.chromium}/bin/chromium";

    export PATH=$PATH:${androidSdk}/libexec/android-sdk/platform-tools;
    export PATH=$PATH:${androidSdk}/libexec/android-sdk/cmdline-tools/latest/bin;
    export PATH=$PATH:${androidSdk}/libexec/android-sdk/emulator;
    export PATH="$PATH":"$HOME/.pub-cache/bin";
  '';
}
