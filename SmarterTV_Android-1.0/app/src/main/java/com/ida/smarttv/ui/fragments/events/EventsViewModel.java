package com.ida.smarttv.ui.fragments.events;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.MutableLiveData;

import com.ida.smarttv.data.Repository;
import com.ida.smarttv.data.remote.model.EventResponse;

public class EventsViewModel extends AndroidViewModel {

    Repository repository;

    public EventsViewModel(@NonNull Application application) {
        super(application);
        repository = new Repository(application);
    }


    public MutableLiveData<EventResponse> showEvents(String username) {
        return repository.showAllEventsForUser(username);
    }


    public void deleteEvent(int id) {
         repository.deleteEvent(id);
    }


}
