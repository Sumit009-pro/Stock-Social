package com.example.stock_social

import io.flutter.embedding.android.FlutterActivity
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger

//
//class MainActivity: FlutterActivity() {
//}


import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine
import androidx.annotation.NonNull
class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }}



//
//import io.flutter.app.FlutterApplication
//import io.flutter.plugin.common.PluginRegistry
//import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
//import io.flutter.plugins.GeneratedPluginRegistrant
//import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
//
//
//class MainActivity : FlutterApplication(), PluginRegistrantCallback {
//    fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
//    }
//
//    fun registerWith(registry: PluginRegistry) {
//        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//    }
//}
//
