package com.ida.smarttv.ui.fragments.events;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.fragment.NavHostFragment;
import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.ItemTouchHelper;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.ida.smarttv.R;
import com.ida.smarttv.data.remote.model.Event;
import com.ida.smarttv.data.remote.model.EventResponse;
import com.ida.smarttv.ui.adapters.EventListAdapter;
import com.ida.smarttv.utils.AppConstants;
import com.ida.smarttv.utils.Prefs;

import org.jetbrains.annotations.NotNull;

public class EventsFragment extends Fragment {
    private RecyclerView recyclerView;
    private TextView tv_event_creator_name;
    private FloatingActionButton add_event;

    EventListAdapter adapter;
     NavController navController;


    private EventsViewModel mViewModel;

    public static EventsFragment newInstance() {
        return new EventsFragment();
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.events_fragment, container, false);
    }


    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        recyclerView = view.findViewById(R.id.rv_events);
        tv_event_creator_name = view.findViewById(R.id.tv_events_created_for);
        add_event = view.findViewById(R.id.add_event_action);
        recyclerView.setLayoutManager(new LinearLayoutManager(this.getContext()));
        recyclerView.setHasFixedSize(true);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        adapter = new EventListAdapter();
        recyclerView.setAdapter(adapter);

       navController = Navigation.findNavController(view);





    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mViewModel = ViewModelProviders.of(this).get(EventsViewModel.class);

        String userName = Prefs.getPreferences(getContext(), AppConstants.USER_NAME);

        ItemTouchHelper helper = new ItemTouchHelper(
                new ItemTouchHelper.SimpleCallback(0,
                        ItemTouchHelper.LEFT | ItemTouchHelper.RIGHT) {
                    @Override
                    // We are not implementing onMove() in this app.
                    public boolean onMove(@NotNull RecyclerView recyclerView,
                                          @NotNull RecyclerView.ViewHolder viewHolder,
                                          @NotNull RecyclerView.ViewHolder target) {
                        return false;
                    }

                    @Override
                    // When the use swipes a word,
                    // delete that word from the database.
                    public void onSwiped(@NotNull RecyclerView.ViewHolder viewHolder, int direction) {
                        final int position = viewHolder.getAdapterPosition();
                        Event event = adapter.getEventAt(position);
                        Toast.makeText(getContext(), "Deleted event .." + event.getEvent_name(), Toast.LENGTH_SHORT).show();
                        mViewModel.deleteEvent(event.getId());
                        adapter.removeItem(position);

                    }
                });
        // Attach the item touch helper to the recycler view.
        helper.attachToRecyclerView(recyclerView);


        mViewModel.showEvents(userName).observe(getViewLifecycleOwner(), new Observer<EventResponse>() {
            @Override
            public void onChanged(EventResponse eventResponse) {
                if (eventResponse != null) {
                    adapter.setEventList(eventResponse.getEvents());
                }


            }
        });


        add_event.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                navController.navigate(R.id.action_eventsFragment_to_addEventFragment);
            }
        });

    }

}
