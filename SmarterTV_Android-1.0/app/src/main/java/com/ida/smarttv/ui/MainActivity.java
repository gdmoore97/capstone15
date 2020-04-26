package com.ida.smarttv.ui;

import android.os.Bundle;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.ida.smarttv.R;
import com.ida.smarttv.utils.AppConstants;
import com.ida.smarttv.utils.Prefs;

import timber.log.Timber;

public class MainActivity extends AppCompatActivity {
    NavController navController;
    Toolbar toolbar;
    AppBarConfiguration appBarConfiguration;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        toolbar = findViewById(R.id.toolbar);
        toolbar.setTitleTextColor(getColor(R.color.white));

        navController = Navigation.findNavController(this, R.id.nav_host_fragment);


        appBarConfiguration =
                new AppBarConfiguration.Builder(R.id.login,
                        R.id.registration,
                        R.id.home).build();
        NavigationUI.setupWithNavController(
                toolbar, navController, appBarConfiguration);

    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.logout:
                Timber.d("logout called");
                Prefs.setBoolean(AppConstants.LOGIN_STATUS, false);
                Prefs.setPreferences(getApplicationContext(), AppConstants.USER_ID, null);
                Prefs.setPreferences(getApplicationContext(), AppConstants.USER_NAME, null);
                navController.navigate(R.id.login);
                break;

        }
        return true;

    }
}
