package com.example.fido2_kav_app;

import android.os.Bundle;
import android.util.Log;

import com.example.fido2_kav_app.kavService.CheckRootFunc;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.checkroot/channel";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Khởi tạo MethodChannel
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("checkRoot")) {
                        // Gọi trực tiếp phương thức tĩnh từ CheckRootFunc
                        CheckRootFunc.isDeviceRooted(getApplicationContext(), result);
                    } else {
                        result.notImplemented();
                    }
                });
    }
}