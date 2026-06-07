#! /system/bin/sh
# Source: Miguel Gomes Viana.

# Variables.
data="/sdcard/sim_data"
uid=1000

# Functions.
function build() {
  mkdir -p "${data}"
  cd "${data}"
  
  apps="com.android.chrome
  com.android.vending
  com.facebook.katana
  com.google.android.apps.maps
  com.google.android.apps.photos
  com.google.android.gms
  com.google.android.youtube
  com.instagram.android
  com.microsoft.skydrive
  com.osp.app.signin
  com.samsung.android.app.notes
  com.samsung.android.app.routines
  com.samsung.android.app.smartcapture
  com.samsung.android.calendar
  com.samsung.android.forest
  com.samsung.android.game.gamehome
  com.samsung.android.mapsagent
  com.samsung.android.messaging
  com.samsung.android.rubin.app
  com.sec.android.app.clockpackage
  com.sec.android.app.myfiles 
  com.sec.android.app.sbrowser
  com.sec.android.gallery3d
  com.sec.android.mimage.photoretouching
  com.tiktok.android
  com.whatsapp"
  
  mkdir -p app
  mkdir -p app-lib
  mkdir -p data
  mkdir -p system
  mkdir -p user
  
  # 1. app:
  for i in $apps; do
    cd "${data}/app" || exit
    mkdir -p "$i-9XpWmVmN4z8Z=="
    
    cd "$i-9XpWmVmN4z8Z==" || exit
    
    mkdir -p lib
    mkdir -p lib/arm64
    mkdir -p oat
    mkdir -p oat/arm64
    touch base.dm
    
    echo "APK_BINARY_DATA_STREAM" > base.apk
    echo "MANIFEST_XML_DEFINITION" > AndroidManifest.xml
    echo "SIGNING_BLOCK_SHA256" > cert.rsa
    echo "ELF_64_NATIVE_CORE" > lib/arm64/libnative_core.so
    echo "ELF_64_ENGINE_MODULE" > lib/arm64/libengine.so
    echo "ELF_64_RENDERER_PIPELINE" > lib/arm64/librender.so
    echo "ART_AOT_DEX_OPTIMIZED" > oat/arm64/base.odex
    echo "ART_VDEX_VERIFIED_CODE" > oat/arm64/base.vdex
  done
  
  # 2. app-lib:
  for i in $apps; do
    cd "${data}/app-lib" || exit
    mkdir -p "$i"
    
    cd "$i" || exit
    
    mkdir -p arm64-v8a
    mkdir -p armeabi-v7a
    mkdir -p x86_64
    
    echo "ELF_ARM64_NATIVE_CORE" > arm64-v8a/libnative_core.so
    echo "ELF_ARM64_NATIVE_CRASH" > arm64-v8a/libbreakpad.so
    echo "ELF_ARM64_GRAPHICS" > arm64-v8a/libgles_engine.so
    echo "ELF_ARM64_AUDIO_DECODER" > arm64-v8a/libaudioprocess.so
    echo "ELF_ARM64_NET_SECURE" > arm64-v8a/libssl_crypto.so
    echo "ELF_ARM64_COMPRESSION" > arm64-v8a/libz_utils.so
    echo "ELF_ARM32_NATIVE_CORE" > armeabi-v7a/libnative_core.so
    echo "ELF_ARM32_NATIVE_CRASH" > armeabi-v7a/libbreakpad.so
    echo "ELF_ARM32_GRAPHICS" > armeabi-v7a/libgles_engine.so
    echo "ELF_ARM32_AUDIO_DECODER" > armeabi-v7a/libaudioprocess.so
    echo "ELF_ARM32_NET_SECURE" > armeabi-v7a/libssl_crypto.so
    echo "ELF_ARM32_COMPRESSION" > armeabi-v7a/libz_utils.so
    echo "ELF_X86_64_NATIVE_CORE" > x86_64/libnative_core.so
    echo "ELF_X86_64_GRAPHICS" > x86_64/libgles_engine.so
    echo "ELF_X86_64_AUDIO_DECODER" > x86_64/libaudioprocess.so
    echo "ELF_X86_64_NET_SECURE" > x86_64/libssl_crypto.so
    echo "ELF_X86_64_COMPRESSION" > x86_64/libz_utils.so
  done
  
  # 3. data:
  for i in $apps; do
    cd "${data}/data" || exit
    mkdir -p "$i"
    
    cd "$i" || exit
    
    mkdir -p app_dxprofile
    mkdir -p app_firebase/analytics
    mkdir -p app_firebase/messaging
    mkdir -p app_flutter
    mkdir -p app_textures
    mkdir -p app_webview/local_storage
    mkdir -p app_webview/session_storage
    mkdir -p cache/http
    mkdir -p cache/images
    mkdir -p code_cache
    mkdir -p databases
    mkdir -p files/documents
    mkdir -p files/downloads
    mkdir -p no_backup
    mkdir -p shared_prefs
    mkdir -p telemetry_logs
    
    echo "SQLITE_DB_BINARY_STREAM" > databases/main.db
    echo "SQLITE_JOURNAL_LOG" > databases/main.db-journal
    echo "SQLITE_DB_BINARY_STREAM" > databases/analytics.db
    echo "SQLITE_JOURNAL_LOG" > databases/analytics.db-journal
    echo -e "<map><string name=\"session_key\" value=\"auth\" /></map>" > shared_prefs/${i}_preferences.xml
    echo -e "<map><boolean name=\"analytics_enabled\" value=\"true\" /></map>" > shared_prefs/analytics_settings.xml
    echo -e "<map><int name=\"launch_count\" value=\"42\" /></map>" > shared_prefs/runtime_stats.xml
    echo "OPTIMIZED_DEX_BINARY" > code_cache/compiled_methods.dex
    echo "WEBVIEW_COOKIE_DATA" > app_webview/local_storage/cookies.dat
    echo "WEBVIEW_SESSION_BLOB" > app_webview/session_storage/state.bin
    echo "DEVICE_TOKEN_IDENTIFIER" > app_firebase/messaging/token.token
    echo "ANALYTICS_MANIFEST_PAYLOAD" > app_firebase/analytics/manifest.json
    echo "USER_SENSITIVE_SEED" > no_backup/identity.key
    echo "FLUTTER_ENGINE_STATE" > app_flutter/engine.snapshot

    local j=1
    while [ $j -le 10 ]; do
        echo "HTTP_CACHE_STREAM_RESPONSE" > cache/http/cache_raw_${j}.tmp
        echo "IMAGE_COMPRESSED_RGBA_DATA" > cache/images/img_thumb_${j}.webp
        echo "USER_SAVED_LOCAL_DOCUMENT" > files/documents/doc_save_${j}.json
        echo "PARTIAL_DOWNLOAD_STREAM" > files/downloads/part_${j}.bin
        echo "GPU_TEXTURE_COMPRESSED_ETC2" > app_textures/tex_mip_${j}.pkm
        echo "RUNTIME_AOT_PROFILE_METRIC" > app_dxprofile/profile_node_${j}.prof
        echo "APP_HEALTH_CRASH_DUMP_STACK" > telemetry_logs/event_log_${j}.err
        j=$((j + 1))
    done
  done
  
  # 4. system:
  cd "${data}/system" || exit
  
  mkdir -p "accessibility"
  mkdir -p "appops"
  mkdir -p "audio"
  mkdir -p "backup"
  mkdir -p "batterystats"
  mkdir -p "brightness"
  mkdir -p "display"
  mkdir -p "inputmethod"
  mkdir -p "job"
  mkdir -p "keystore"
  mkdir -p "locale"
  mkdir -p "ndw"
  mkdir -p "netpolicy"
  mkdir -p "notification"
  mkdir -p "overlays"
  mkdir -p "sensors"
  mkdir -p "shared_prefs"
  mkdir -p "stats"
  mkdir -p "sync"
  mkdir -p "theme"
  mkdir -p "users/${uid}"
  local i=1
  while [ ${i} -le 10 ]; do
    mkdir -p "users/profile_${i}"
    i=$((i + 1))
  done
  mkdir -p "users/managed_profile"
  
  echo -e "<users>\n  <user id=\"${uid}\" flags=\"0x00000013\" name=\"Owner\" />\n</users>" > "users/userlist.xml"
  echo -e "<user version=\"1\">\n  <name>Owner</name>\n</user>" > "users/${uid}/${uid}.xml"
  echo -e "<packages>\n  <package name=\"com.android.systemui\" userId=\"1000\" />\n</packages>" > "packages.xml"
  echo -e "<policies>\n  <device-owner package=\"com.android.settings\" />\n</policies>" > "device_policies.xml"
  echo -e "<permissions>\n  <item name=\"android.permission.CAMERA\" granted=\"true\" />\n</permissions>" > "runtime-permissions.xml"
  echo -e "<settings><setting name=\"brightness\" value=\"100\" /></settings>" > "users/${uid}/settings_secure.xml"
  echo -e "<settings><setting name=\"volume\" value=\"7\" /></settings>" > "users/${uid}/settings_system.xml"
  echo -e "<settings><setting name=\"adb\" value=\"1\" /></settings>" > "users/${uid}/settings_global.xml"
  echo -e "<accounts><account name=\"user@gmail.com\" type=\"com.google\" /></accounts>" > "users/${uid}/accounts.xml"
  echo -e "<jobs><job id=\"1\" service=\"com.android.providers.downloads\" /></jobs>" > "job/jobs.xml"
  echo -e "<map><boolean name=\"dark_mode\" value=\"true\" /></map>" > "shared_prefs/display_settings.xml"
  echo -e "<map><string name=\"font_scale\" value=\"1.0\" /></map>" > "shared_prefs/accessibility.xml"
  echo -e "<map><boolean name=\"wifi_on\" value=\"true\" /></map>" > "shared_prefs/network_preferences.xml"
  echo -e "<map><boolean name=\"bt_discoverable\" value=\"false\" /></map>" > "shared_prefs/bluetooth_settings.xml"
  echo -e "<map><int name=\"timeout\" value=\"30000\" /></map>" > "shared_prefs/power_manager.xml"
  echo -e "<channels><channel id=\"misc\" importance=\"3\" /></channels>" > "notification/channels.xml"
  echo -e "<badges><badge package=\"com.android.vending\" count=\"5\" /></badges>" > "notification/badges.xml"
  echo -e "<policy><zen mode=\"0\" /></policy>" > "notification/zen_policy.xml"
  
  echo "100" > "batterystats.last"
  touch "batterystats.log"
  echo "0" > "users/${uid}/wallpaper_info.xml"
  echo "LE" > "inputmethod/subtypes.xml"
  echo "status=ready" > "sync/status.txt"
  echo "com.android.internal.telephony" > "netpolicy.xml"
  echo "allowed" > "appops.xml"
  echo "en-US" > "locale.last"
  echo "portrait" > "display.orientation"
  echo "normal" > "thermal_mode.conf"
  echo "1234" > "users/${uid}/password.key"
  echo "verified" > "ndw/state.dat"
  echo "default" > "theme/current.cfg"
  echo "backup_enabled=true" > "backup/backup.conf"
  echo "last_token=98765" > "backup/state.token"
  echo "daily" > "stats/report_interval.cfg"
  echo "cpu_freq=2400" > "stats/cpu_perf.info"
  
  local i=1
  while [ ${i} -le 50 ]; do
    echo "state=active" > "package_state_${i}.dat"
    echo "cache_size=4096" > "stats/app_metric_${i}.tmp"
    echo "policy=default" > "appops/appop_policy_${i}.xml"
    echo "target=system" > "overlays/overlay_map_${i}.conf"
    i=$((i + 1))
  done

  # 5. user:
  mkdir -p "${data}/user/0"
  for i in $apps; do
    cd "${data}/user/0" || exit
    mkdir -p "$i"
    
    cd "$i" || exit

    mkdir -p app_dxprofile
    mkdir -p app_firebase/analytics
    mkdir -p app_firebase/messaging
    mkdir -p app_flutter
    mkdir -p app_textures
    mkdir -p app_webview/local_storage
    mkdir -p app_webview/session_storage
    mkdir -p cache/http
    mkdir -p cache/images
    mkdir -p code_cache
    mkdir -p databases
    mkdir -p files/documents
    mkdir -p files/downloads
    mkdir -p no_backup
    mkdir -p shared_prefs
    mkdir -p telemetry_logs
    
    echo "SQLITE_DB_BINARY_STREAM" > databases/main.db
    echo "SQLITE_JOURNAL_LOG" > databases/main.db-journal
    echo "SQLITE_DB_BINARY_STREAM" > databases/analytics.db
    echo "SQLITE_JOURNAL_LOG" > databases/analytics.db-journal
    echo -e "<map><string name=\"session_key\" value=\"auth\" /></map>" > shared_prefs/${i}_preferences.xml
    echo -e "<map><boolean name=\"analytics_enabled\" value=\"true\" /></map>" > shared_prefs/analytics_settings.xml
    echo -e "<map><int name=\"launch_count\" value=\"42\" /></map>" > shared_prefs/runtime_stats.xml
    echo "OPTIMIZED_DEX_BINARY" > code_cache/compiled_methods.dex
    echo "WEBVIEW_COOKIE_DATA" > app_webview/local_storage/cookies.dat
    echo "WEBVIEW_SESSION_BLOB" > app_webview/session_storage/state.bin
    echo "DEVICE_TOKEN_IDENTIFIER" > app_firebase/messaging/token.token
    echo "ANALYTICS_MANIFEST_PAYLOAD" > app_firebase/analytics/manifest.json
    echo "USER_SENSITIVE_SEED" > no_backup/identity.key
    echo "FLUTTER_ENGINE_STATE" > app_flutter/engine.snapshot

    local j=1
    while [ $j -le 10 ]; do
        echo "HTTP_CACHE_STREAM_RESPONSE" > cache/http/cache_raw_${j}.tmp
        echo "IMAGE_COMPRESSED_RGBA_DATA" > cache/images/img_thumb_${j}.webp
        echo "USER_SAVED_LOCAL_DOCUMENT" > files/documents/doc_save_${j}.json
        echo "PARTIAL_DOWNLOAD_STREAM" > files/downloads/part_${j}.bin
        echo "GPU_TEXTURE_COMPRESSED_ETC2" > app_textures/tex_mip_${j}.pkm
        echo "RUNTIME_AOT_PROFILE_METRIC" > app_dxprofile/profile_node_${j}.prof
        echo "APP_HEALTH_CRASH_DUMP_STACK" > telemetry_logs/event_log_${j}.err
        j=$((j + 1))
    done
  done
}

# Code.
build
