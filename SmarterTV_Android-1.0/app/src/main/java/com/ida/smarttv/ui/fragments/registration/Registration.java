package com.ida.smarttv.ui.fragments.registration;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.IdRes;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;

import com.google.android.material.chip.Chip;
import com.google.android.material.chip.ChipGroup;
import com.google.android.material.textfield.TextInputLayout;
import com.ida.smarttv.R;
import com.ida.smarttv.data.remote.model.RegisterModel;

import timber.log.Timber;

public class Registration extends Fragment {
    TextView mLogin;
    ChipGroup mChipGroup;
    TextInputLayout mOwnerUsername, mOwnerFirstName, mOwnerLastName,
            mSelfCareUser, mSelfCare_firstName, mSelfCare_lastName, mSelfCare_password;
    ChipGroup chipGroup;
    NavController navController;

    Button mRegister;

    private boolean tv_ownerSelected = true;

    private RegistrationViewModel mViewModel;

    public static Registration newInstance() {
        return new Registration();
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.registration_fragment, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        navController = Navigation.findNavController(view);
        initView(view);
        showOwnerView(false);

        chipGroup.setOnCheckedChangeListener(new ChipGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(ChipGroup group, @IdRes int checkedId) {
                Chip chip = group.findViewById(checkedId);
                if (chip != null) {
                    if (chip.getId() == R.id.tv_owner) {
                        Timber.d("tv owner selected");
                        showOwnerView(false);
                    } else {
                        showOwnerView(true);
                        Timber.d("tv self care selected");
                    }
                }
            }
        });


        mLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navController.navigate(R.id.login);
            }
        });


    }

    private void initView(View view) {
        mLogin = view.findViewById(R.id.tv_login);
        chipGroup = view.findViewById(R.id.chip_group);
        mOwnerUsername = view.findViewById(R.id.register_owner_username);
        mOwnerFirstName = view.findViewById(R.id.register_owener_fn);
        mOwnerLastName = view.findViewById(R.id.register_owner_ln);
        mSelfCareUser = view.findViewById(R.id.register_layout_username);
        mSelfCare_firstName = view.findViewById(R.id.register_first_name);
        mSelfCare_lastName = view.findViewById(R.id.resgister_last_name);
        mSelfCare_password = view.findViewById(R.id.register_layout_pd);
        mRegister = view.findViewById(R.id.btn_register);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mViewModel = ViewModelProviders.of(this).get(RegistrationViewModel.class);


        mRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {


                register();

            }
        });
    }


    private void showOwnerView(Boolean status) {
        if (status) {
            tv_ownerSelected = false;
            mOwnerUsername.setVisibility(View.VISIBLE);
            mOwnerFirstName.setVisibility(View.VISIBLE);
            mOwnerLastName.setVisibility(View.VISIBLE);
        } else {
            tv_ownerSelected = true;
            mOwnerUsername.setVisibility(View.GONE);
            mOwnerFirstName.setVisibility(View.GONE);
            mOwnerLastName.setVisibility(View.GONE);
        }
    }


    private void register() {
        String selfCareUserName = mSelfCareUser.getEditText().getText().toString();
        String selfCareFullName = (mSelfCare_firstName.getEditText().getText().toString()
                + mSelfCare_lastName.getEditText().getText().toString());
        String selfPassword = mSelfCare_password.getEditText().getText().toString();

        String ownerUsername = mOwnerUsername.getEditText().getText().toString();
        String ownerFullName = (mOwnerFirstName.getEditText().getText().toString() +
                mOwnerLastName.getEditText().getText().toString());


        if (tv_ownerSelected) {
            if (valid()) {
                mViewModel.repository.register_owner(selfCareUserName, selfPassword,
                        selfCareFullName).observe(this, new Observer<RegisterModel>() {
                    @Override
                    public void onChanged(RegisterModel registerModel) {
                        if (registerModel != null) {
                            if (registerModel.getStatus().equalsIgnoreCase("200")) {
                                Timber.d("success fully register tv owner");
                                Toast.makeText(getContext(), "Successfully register as Tv owner", Toast.LENGTH_SHORT).show();
                            } else {
                                Toast.makeText(getContext(), "Missing Information", Toast.LENGTH_SHORT).show();
                            }
                        }
                    }
                });
            }

        } else {
            if (valid()) {
                mViewModel.repository.register_caregiver(selfCareUserName, selfPassword,
                        selfCareFullName, ownerFullName, ownerUsername).observe(this, new Observer<RegisterModel>() {
                    @Override
                    public void onChanged(RegisterModel registerModel) {
                        if (registerModel != null) {
                            if (registerModel.getStatus().equalsIgnoreCase("200")) {
                                Timber.d("successfully register as self care");
                                Toast.makeText(getContext(), "Successfully register as self care Owner", Toast.LENGTH_SHORT).show();
                            } else {
                                Toast.makeText(getContext(), "check Owner Details", Toast.LENGTH_SHORT).show();

                            }
                        }

                    }
                });

            }

        }


    }

    private Boolean valid() {

        if (tv_ownerSelected) {

            if (mSelfCareUser.getEditText().getText().length() > 2 &&
                    mSelfCare_firstName.getEditText().getText().length() > 1 &&
                    mSelfCare_lastName.getEditText().getText().length() > 1 &&
                    mSelfCare_password.getEditText().getText().length() > 3) {

                return true;

            } else {


                return false;


            }


        } else {

            if (mSelfCareUser.getEditText().getText().length() > 2 &&
                    mSelfCare_firstName.getEditText().getText().length() > 1 &&
                    mSelfCare_lastName.getEditText().getText().length() > 1 &&
                    mSelfCare_password.getEditText().getText().length() > 3 &&
                    mOwnerUsername.getEditText().getText().length() > 1 &&
                    mOwnerFirstName.getEditText().getText().length() > 1 &&
                    mOwnerLastName.getEditText().getText().length() > 1) {
                return true;

            } else {

                return false;


            }


        }


    }
}
