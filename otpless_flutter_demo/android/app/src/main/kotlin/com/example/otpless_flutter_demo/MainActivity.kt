package com.digvijayanubhav.app

import io.flutter.embedding.android.FlutterActivity
import com.example.otpless_flutter.OtplessFlutterPlugin
import android.content.Intent

class MainActivity: FlutterActivity() {
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
 super.onActivityResult(requestCode, resultCode, data)
 val plugin = flutterEngine?.plugins?.get(OtplessFlutterPlugin::class.java) 
 if (plugin is OtplessFlutterPlugin) {
  plugin.onActivityResult(requestCode, resultCode, data) 
 }
}
}
