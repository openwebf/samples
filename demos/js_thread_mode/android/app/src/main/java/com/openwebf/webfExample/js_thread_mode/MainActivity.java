package com.openwebf.webfExample.js_thread_mode;

import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineGroup;
import io.flutter.embedding.engine.FlutterEngineGroupCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterMain;

public class MainActivity extends FlutterActivity {
    MethodChannel methodChannel;
    FlutterEngineGroup engineGroup;
    private final BroadcastReceiver flutterActivityStoppedReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            // 在这里处理 FlutterActivityStopped 广播
            Log.d("MyActivity", "FlutterActivityStopped received");
            if (engineGroup != null) {
                FlutterEngineGroupCache.getInstance().remove("my_cached_engine_group_id");
                engineGroup = null;
                Log.d("MyActivity", "FlutterEngineGroupCache remove my_cached_engine_group_id");
            }
        }
    };

    @SuppressLint("WrongConstant")
    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("MainActivity", "onCreate called - MainActivity is starting");

        IntentFilter filter = new IntentFilter("FlutterActivityStopped");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            Log.d("MainActivity", "registerReceiver - FlutterActivityStopped");
            registerReceiver(flutterActivityStoppedReceiver, filter, Context.RECEIVER_EXPORTED);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterReceiver(flutterActivityStoppedReceiver);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        Log.d("MainActivity", "Configuring Flutter Engine");

        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.example.flutter/new_engine");
        methodChannel.setMethodCallHandler((call, result) -> {
                    Log.d("MainActivity", "Received method: " + call.method);
                    if (call.method.equals("newFlutterEngine")) {
                        openNewFlutterEngineActivity();
                    } else if (call.method.equals("newFlutterEngineWithoutFlutterEngineGroup")) {
                        openNewFlutterEngineWithoutGroupActivity();
                    } else {
                        result.notImplemented();
                    }
                });
    }

    private void openNewFlutterEngineActivity() {
        Log.d("MainActivity", "Starting new Flutter engine activity with group.");
        if (engineGroup != null) {
            return;
        }

        engineGroup = new FlutterEngineGroup(this);
        FlutterEngineGroupCache.getInstance().put("my_cached_engine_group_id", engineGroup);

        Intent intent = FlutterActivity.withNewEngineInGroup("my_cached_engine_group_id")
                .dartEntrypoint("mainWithoutNewEngine")
                .build(this);
        startActivity(intent);
    }

    private void openNewFlutterEngineWithoutGroupActivity() {
        Log.d("MainActivity", "Starting new Flutter engine activity without group.");
        // Creates and launches a new FlutterActivity without using an engine group
        Intent intent = FlutterActivity
                .withNewEngine()
                .build(this);
        startActivity(intent);
    }
}
