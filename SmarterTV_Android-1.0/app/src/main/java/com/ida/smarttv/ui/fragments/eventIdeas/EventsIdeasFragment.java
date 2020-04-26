package com.ida.smarttv.ui.fragments.eventIdeas;

import androidx.lifecycle.ViewModelProviders;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.ida.smarttv.R;

public class EventsIdeasFragment extends Fragment {

    private EventsIdeasViewModel mViewModel;

    public static EventsIdeasFragment newInstance() {
        return new EventsIdeasFragment();
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.events_ideas_fragment, container, false);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mViewModel = ViewModelProviders.of(this).get(EventsIdeasViewModel.class);
        // TODO: Use the ViewModel
    }

}
