package com.ida.smarttv.ui.fragments.login;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
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

import com.google.android.material.textfield.TextInputLayout;
import com.ida.smarttv.R;
import com.ida.smarttv.data.remote.model.LoginModel;
import com.ida.smarttv.utils.AppConstants;
import com.ida.smarttv.utils.Prefs;

import java.util.Objects;

import timber.log.Timber;

public class Login extends Fragment {

    TextView mRegister;
    TextInputLayout mLayout_userName, mLayout_password;
    Button mLogin;
    NavController navController;
    private LoginViewModel mViewModel;

    public static Login newInstance() {
        return new Login();
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.login_fragment, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        initViews(view);
        navController = Navigation.findNavController(view);
        checkIfLogin();

        mRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navController.navigate(R.id.registration);
            }
        });
    }

    private void checkIfLogin() {
        boolean userLoggedIn = Prefs.getBoolean(AppConstants.LOGIN_STATUS, false);
        if (userLoggedIn) {
            NavHostFragment.findNavController(this).navigate(R.id.home, null);
        }
    }

    private void initViews(View view) {
        mRegister = view.findViewById(R.id.sign_up);
        mLayout_userName = view.findViewById(R.id.input_layout_username);
        mLayout_password = view.findViewById(R.id.input_layout_pd);
        mLogin = view.findViewById(R.id.btn_login);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mViewModel = ViewModelProviders.of(this).get(LoginViewModel.class);

        mLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String username = Objects.requireNonNull(mLayout_userName.getEditText()).getText().toString();
                String password = Objects.requireNonNull(mLayout_password.getEditText()).getText().toString();
                Timber.d("username : %s  and password is %s", username, password);

                if (username.isEmpty()) {
                    mLayout_userName.setError("please enter username");
                } else if (!validatePassword(password)) {
                    mLayout_password.setError("Not a valid password!");
                } else {
                    mLayout_userName.setErrorEnabled(false);
                    mLayout_password.setErrorEnabled(false);
                    doLogin(username, password);
                }
            }
        });

    }

    private void doLogin(String username, String password) {
        mViewModel.repository.login(username, password).observe(getViewLifecycleOwner(), new Observer<LoginModel>() {
            @Override
            public void onChanged(LoginModel loginModel) {
                if (loginModel != null) {

                    if (loginModel.getStatus().equalsIgnoreCase("200")) {

                        Timber.d("successfully login");
                        Prefs.setBoolean(AppConstants.LOGIN_STATUS, true);
                        Prefs.setPreferences(getContext(), AppConstants.USER_ID, loginModel.getId());
                        Prefs.setPreferences(getContext(), AppConstants.USER_NAME, loginModel.getUsername());
                        Toast.makeText(getContext(), loginModel.getMessage(), Toast.LENGTH_SHORT).show();
                        navController.navigate(R.id.home);
                    } else {
                        Timber.d("error occurred");
                        Toast.makeText(getContext(), loginModel.getMessage(), Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });
    }

    private boolean validatePassword(String password) {
        return password.length() > 3;
    }


    private void Validation() {
        String username = mLayout_userName.getEditText().getText().toString();
        String password = mLayout_userName.getEditText().getText().toString();


    }


}
