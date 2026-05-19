# NUT Client for macOS

A lightweight, fully native macOS menu bar monitor for your Uninterruptible Power Supply (UPS) powered by [Network UPS Tools (NUT)](https://networkupstools.org/). 

![ScreenShot](screenshot.png)

This project is a pure Swift/AppKit/SwiftUI port of the original Electron-based [vitaliystoyanov/nut-client](https://github.com/vitaliystoyanov/nut-client), designed to drop the heavy Chromium overhead and deliver a seamless, battery-friendly macOS experience.

--

### Features

* **100% Native:** Built with Swift, AppKit, and SwiftUI. No Electron, no web views.
* **Menu Bar Agent:** Sits quietly in your menu bar with a dynamic icon that changes based on your battery status (AC Power, On Battery, Low Battery).
* **Dynamic Variable Discovery:** Automatically detects all variables your specific UPS hardware supports (Voltages, Frequencies, Temperatures, Loads) and maps them into human-readable formats.
* **Highly Customizable:** Choose exactly which stats you want to see in your menu bar dropdown via the Preferences window, categorized beautifully.
* **Auto-Reconnection:** Built-in network resilience. If your NUT server reboots or your Mac goes to sleep, the app will automatically handle the raw TCP socket teardown and quietly reconnect in the background.
* **System Integration:**
  * Launch at Login support (uses modern `SMAppService` on macOS 13+).
  * Toggle to hide/show the Dock icon natively.
* **Backward Compatible:** Supports macOS 12 (Monterey) and newer.



![macOS](https://img.shields.io/badge/macOS-12.0+-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![License](https://img.shields.io/badge/License-GPL-blue?style=for-the-badge)