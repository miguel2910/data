# data
A lightweight Shell Script designed to simulate a realistic Android internal directory tree and file mock infrastructure inside `/sdcard/data`. 

Created by **Miguel Gomes Viana**.

## 🚀 Purpose
This script generates a mock representation of Android's internal system files, application preferences, cache patterns, runtime logs, and user architectures (`user/0`). It is highly useful for:
* Testing automation scripts and Android backup tools.
* Developing or debugging Android file managers.
* Creating safe sandbox environments for digital forensics training and testing.
* Simulating application behaviors without exposing real user sensitive data.

## 📁 Simulated Structure Overview
The script populates a root directory at `/sdcard/sim_data` mimicking key system components:
1. **`app/`**: Application binaries, manifests, certificates, and OAT optimization blocks for 26 popular packages (WhatsApp, Chrome, Samsung core apps, etc.).
2. **`app-lib/`**: Native library architecture maps (`arm64-v8a`, `armeabi-v7a`, `x86_64`).
3. **`data/` & `user/0/`**: Runtime databases (SQLite simulator streams), Firebase tokens, Flutter engine states, encrypted key mocks, WebView local cache, and structured HTTP/Image footprints.
4. **`system/`**: Comprehensive Android system configuration mocks including userlists (`Owner` with UID 1000), battery history logs, runtime permission maps, system secure XML preferences, and overlay tables.

## 🛠️ How to Use

### Prerequisites
* A device or environment running an Android-based shell interpreter (`/system/bin/sh`).
* Adequate storage permissions on `/sdcard/`.

### Execution
1. Transfer the script to your Android device via ADB or an application like Termux.
2. Grant execution permissions:
   ```bash
   chmod +x sim_android_structure.sh
   ```
3. Run the script:
   ```bash
   ./sim_android_structure.sh
   ```

## 📜 License
This project is licensed under the GNU GPL-3.0 License - see the [LICENSE](LICENSE).
