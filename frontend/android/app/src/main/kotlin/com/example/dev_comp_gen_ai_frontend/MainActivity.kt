package com.example.dev_comp_gen_ai_frontend

import io.flutter.embedding.android.FlutterActivity

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import com.google.ar.core.ArCoreApk

import android.util.Log
import android.widget.Toast
import com.google.ar.core.CameraConfig
import com.google.ar.core.CameraConfigFilter
import com.google.ar.core.Config
import com.google.ar.core.Config.InstantPlacementMode
import com.google.ar.core.Session
import com.google.ar.core.exceptions.CameraNotAvailableException
import com.google.ar.core.exceptions.UnavailableApkTooOldException
import com.google.ar.core.exceptions.UnavailableDeviceNotCompatibleException
import com.google.ar.core.exceptions.UnavailableSdkTooOldException
import com.google.ar.core.exceptions.UnavailableUserDeclinedInstallationException


class MainActivity: FlutterActivity(){
    private val CHANNEL = "flutter.native/helper"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result -> 
            when {
                call.method.equals("changeColor") -> {
                    changeColor(call, result)
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
      
        // Enable AR-related functionality on ARCore supported devices only.
        maybeEnableArButton()
    
      }
      
      fun maybeEnableArButton() {
        ArCoreApk.getInstance().checkAvailabilityAsync(this) { availability ->
          if (availability.isSupported) {
            mArButton.visibility = View.VISIBLE
            mArButton.isEnabled = true
          } else { // The device is unsupported or unknown.
            mArButton.visibility = View.INVISIBLE
            mArButton.isEnabled = false
          }
        }
      }

    private fun changeColor(call: MethodCall, result: MethodChannel.Result) {
        var color = call.argument<String>("color");
        result.success(color);
    }
}
