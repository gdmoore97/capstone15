package com.ida.smarttv;

import android.app.Application;

import com.ida.smarttv.utils.CrashReportingTree;

import timber.log.Timber;

public class BaseApplication extends Application {

    private static BaseApplication instance;


    /**
     * To get the Application context globally
     */


    public static BaseApplication getInstance() {
        return instance;
    }

    public BaseApplication() {
        instance = this;
    }


    @Override
    public void onCreate() {
        super.onCreate();

        Timber.plant(BuildConfig.DEBUG
                ? new Timber.DebugTree()
                : new CrashReportingTree());
    }
}
