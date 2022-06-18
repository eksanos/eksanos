# Eksanos

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.eksanos.eksanos)

A simple TicTacToe app made for elementary OS.

![Screenshot of the app](https://raw.githubusercontent.com/eksanos/eksanos/main/data/screenshots/eksanos_menu_banana.png)


## Building
### Dependencies
Eksanos requires the following:
* glib-2.0
* gtk4
* granite-7
* libadwaita-1 >= 1.0.0
* meson
* valac

### Via Flatpak
Build and install it as a Flatpak by running the following command:

`flatpak-builder build com.github.eksanos.eksanos.yml --user --install --force-clean`

Make sure you have the elementary sdk installed, if you don't already. Release 1.1.0 and below use the 6.1 SDK. Releases greater than 1.1.0 will use the 7 SDK. 

`flatpak install io.elementary.Sdk`

### Via Meson
First in the project's root directory, run:

`meson build --prefix=/usr`

You can optionally omit `--prefix=/usr` if you want to install it locally, rather than for all users

Then run the following commands:
```
cd build
ninja
ninja install
```

## Running
After building and installing, you can simply run the app from your application menu, or in the terminal by running:

`com.github.eksanos.eksanos`
