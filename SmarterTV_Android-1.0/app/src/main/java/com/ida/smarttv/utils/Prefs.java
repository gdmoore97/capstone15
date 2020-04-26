package com.ida.smarttv.utils;

import android.content.Context;
import android.content.SharedPreferences;

import com.ida.smarttv.BaseApplication;

public class Prefs {

    static Context mContext;

    public static void setPreferences(Context context, String key, String value) {
        mContext = context;
        SharedPreferences.Editor editor = mContext.getSharedPreferences(
                "smart_tv", Context.MODE_PRIVATE).edit();
        editor.putString(key, value);
        editor.apply();
    }

    public static String getPreferences(Context context, String key) {
        mContext = context;
        SharedPreferences prefs = mContext.getSharedPreferences("smart_tv",
                Context.MODE_PRIVATE);
        String position = prefs.getString(key, "");
        return position;
    }

    public static boolean getBoolean(String key, boolean default_value) {
        Context context = BaseApplication.getInstance();
        SharedPreferences prefs = context.getSharedPreferences("smart_tv",
                Context.MODE_PRIVATE);
        return prefs.getBoolean(key, default_value);

    }

    public static void setBoolean(String key, boolean value) {
        Context context = BaseApplication.getInstance();
        SharedPreferences.Editor editor = context.getSharedPreferences(
                "smart_tv", Context.MODE_PRIVATE).edit();
        editor.putBoolean(key, value);
        editor.apply();
    }
}
