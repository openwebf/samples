package com.openwebf.webfExample.js_thread_mode;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;

public class MyApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(@NonNull Activity activity, @Nullable Bundle savedInstanceState) {

            }

            @Override
            public void onActivityStarted(Activity activity) {}

            @Override
            public void onActivityResumed(Activity activity) {}

            @Override
            public void onActivityPaused(Activity activity) {}

            @Override
            public void onActivityStopped(Activity activity) {
                Log.d("MyApplication", "onActivityStopped has stopped " + activity.getLocalClassName());

                if (activity.getLocalClassName().equals("io.flutter.embedding.android.FlutterActivity")) {
                    Log.d("MyApplication", "MyFlutterActivity has stopped");
                    Intent intent = new Intent("FlutterActivityStopped");
                    sendBroadcast(intent);
                }
            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {}

            @Override
            public void onActivityDestroyed(Activity activity) {}
        });
    }
}