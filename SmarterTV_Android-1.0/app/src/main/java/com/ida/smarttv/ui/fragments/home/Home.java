package com.ida.smarttv.ui.fragments.home;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProviders;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;

import com.ida.smarttv.R;
import com.ida.smarttv.utils.AppConstants;
import com.ida.smarttv.utils.Prefs;

public class Home extends Fragment {

    Button mEvents, mEventIdeas, mLogout;


    private HomeViewModel mViewModel;
    NavController navController;

    public static Home newInstance() {
        return new Home();
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.home_fragment, container, false);
    }


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final NavController navController = Navigation.findNavController(view);

        mEventIdeas = view.findViewById(R.id.btn_eventideas);
        mEvents = view.findViewById(R.id.btn_event);
        mLogout = view.findViewById(R.id.btn_logout);

        mEvents.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navController.navigate(R.id.eventsFragment);
            }
        });


        mLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Prefs.setBoolean(AppConstants.LOGIN_STATUS, false);
                Prefs.setPreferences(getContext(), AppConstants.USER_ID, null);
                Prefs.setPreferences(getContext(), AppConstants.USER_NAME, null);
                navController.navigate(R.id.login);
            }
        });
    }


    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mViewModel = ViewModelProviders.of(this).get(HomeViewModel.class);

    }

}
