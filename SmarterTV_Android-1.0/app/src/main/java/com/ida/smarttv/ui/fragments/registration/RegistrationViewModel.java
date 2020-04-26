package com.ida.smarttv.ui.fragments.registration;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.MutableLiveData;

import com.ida.smarttv.data.Repository;
import com.ida.smarttv.data.remote.model.RegisterModel;

public class RegistrationViewModel extends AndroidViewModel {
    Repository repository;

    public RegistrationViewModel(@NonNull Application application) {
        super(application);
        repository = new Repository(application);
    }


    public MutableLiveData<RegisterModel> registerTvOwner(String username, String password, String fullName) {
        return repository.register_owner(username, password, fullName);
    }


    public MutableLiveData<RegisterModel> registerSelfCare(String username,
                                                           String password,
                                                           String fullName, String owner_fullName,
                                                           String ownerUsername) {
        return repository.register_caregiver(username, password, fullName, owner_fullName, ownerUsername);
    }
}
