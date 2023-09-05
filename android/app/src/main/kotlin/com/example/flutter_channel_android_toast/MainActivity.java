package com.example.flutter_channel_android_toast;

import android.widget.Toast;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

// Change the extension of the  class from kt to java
public  class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),"MASK");
        channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//            results hae the data that we send from the flutter to the android

            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

                if (call.method.equals("showToast")){
//                    The data must be send or received by the Key value pair or in the form of map
                    HashMap<String,String> resultMap = (HashMap<String, String>) call.arguments;
                    //               message is the key name that we sent from the flutter
                    String message = resultMap.get("message");
                    Toast.makeText(MainActivity.this, message, Toast.LENGTH_SHORT).show();
//                    now we use th map to send data to the flutter in the form of key value pair
                    HashMap<String,String> map = new HashMap<>();
                    map.put("result" , "Congratulation You have Achieved Flutter Channels \n Data Send from Android to Flutter");
                    result.success(map);
                }
            }
        });
    }
}
