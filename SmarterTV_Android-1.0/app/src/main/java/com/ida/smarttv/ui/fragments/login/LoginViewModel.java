package com.ida.smarttv.ui.fragments.login;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.MutableLiveData;

import com.ida.smarttv.data.Repository;
import com.ida.smarttv.data.remote.model.LoginModel;

public class LoginViewModel extends AndroidViewModel {

    Repository repository;

    public LoginViewModel(@NonNull Application application) {
        super(application);
        repository = new Repository(application);
    }


    private MutableLiveData<LoginModel> login_user(String username, String password) {
        return repository.login(username, password);
    }


}
