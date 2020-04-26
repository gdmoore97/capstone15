package com.ida.smarttv.ui.adapters;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.viewpager2.adapter.FragmentStateAdapter;

import com.ida.smarttv.ui.fragments.eventIdeas.EventsIdeasFragment;
import com.ida.smarttv.ui.fragments.events.EventsFragment;


public class ViewPagerAdapter extends FragmentStateAdapter {

    public ViewPagerAdapter(@NonNull FragmentActivity fragmentActivity) {
        super(fragmentActivity);
    }

    @NonNull
    @Override
    public Fragment createFragment(int position) {
        switch (position) {
            case 1:
                return new EventsIdeasFragment();

            default:
                return new EventsFragment();

        }
    }

    @Override
    public int getItemCount() {
        return 2;
    }
}
