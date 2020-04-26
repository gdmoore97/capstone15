package com.ida.smarttv.data.remote.client;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.concurrent.TimeUnit;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitClient {

    private static final String BASE_URL = "http://smartersmarttv.com/";
    private static Retrofit retrofit = null;
    private static Gson gson;

    public static Gson getGson() {
        if (gson == null) {
            gson = new GsonBuilder()
                    .setLenient()
                    .create();
        }
        return gson;
    }

    public static Retrofit getClient() {
        if (retrofit == null) {
            retrofit = new Retrofit.Builder()
                    .baseUrl(BASE_URL)
                    .client(new OkHttpClient.Builder()
                            .connectTimeout(1, TimeUnit.MINUTES)
                            .readTimeout(1, TimeUnit.MINUTES)
                            .addInterceptor(new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY))
                            .build())
                    .addConverterFactory(GsonConverterFactory.create(getGson()))
                    .build();
        }
        return retrofit;
    }
}
