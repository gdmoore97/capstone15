package com.ida.smarttv.data.remote.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Event {

    @SerializedName("id")
    @Expose
    private Integer id;
    @SerializedName("eventname")
    @Expose
    private String event_name;
    @SerializedName("eventlocation")
    @Expose
    private String event_location;
    @SerializedName("event_date")
    @Expose
    private String event_date;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEvent_name() {
        return event_name;
    }

    public void setEvent_name(String event_name) {
        this.event_name = event_name;
    }

    public String getEvent_location() {
        return event_location;
    }

    public void setEvent_location(String event_location) {
        this.event_location = event_location;
    }

    public String getEvent_date() {
        return event_date;
    }

    public void setEvent_date(String event_date) {
        this.event_date = event_date;
    }
}
