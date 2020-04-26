package com.ida.smarttv.ui.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.ida.smarttv.R;
import com.ida.smarttv.data.remote.model.Event;

import java.util.ArrayList;
import java.util.List;

import timber.log.Timber;

public class EventListAdapter extends RecyclerView.Adapter<EventListAdapter.EventListViewHolder> {
    List<Event> eventList = new ArrayList<>();


    @NonNull
    @Override
    public EventListViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_events, parent, false);
        return new EventListViewHolder(itemView);

    }

    @Override
    public void onBindViewHolder(@NonNull EventListViewHolder holder, int position) {
        if (eventList.get(position) != null) {
            holder.mEventName.setText(eventList.get(position).getEvent_name());
            holder.mEventLocation.setText(eventList.get(position).getEvent_location());
//            String dateTime = eventList.get(position).getEvent_date();
//            Timber.d("date time Received %s", dateTime);
        }

    }

    @Override
    public int getItemCount() {
        return eventList.size();
    }

    public void setEventList(List<Event> eventList) {
        this.eventList = eventList;
        notifyDataSetChanged();
    }

    public Event getEventAt(int position) {
        return eventList.get(position);
    }

    public void removeItem(int position) {
        eventList.remove(position);
        // notify the item removed by position
        // to perform recycler view delete animations
        // NOTE: don't call notifyDataSetChanged()
        notifyItemRemoved(position);
    }


    public class EventListViewHolder extends RecyclerView.ViewHolder {
        TextView mEventName, mEventLocation, mEventDateTime;


        public EventListViewHolder(@NonNull View itemView) {
            super(itemView);
            mEventName = itemView.findViewById(R.id.tv_event_data);
            mEventLocation = itemView.findViewById(R.id.tv_event_locatation);
            mEventDateTime = itemView.findViewById(R.id.tv_event_date_time);


        }
    }
}
