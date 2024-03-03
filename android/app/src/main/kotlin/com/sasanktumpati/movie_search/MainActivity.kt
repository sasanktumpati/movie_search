package com.sasanktumpati.movie_search

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "android_app_retain").apply {
        setMethodCallHandler { method, result ->
            if (method.method == "sendToBackground") {
                moveTaskToBack(true)
            }
        }
    }
}
}