package com.digvijayanubhav.app;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.otpless.dto.OtplessResponse;
import com.otpless.main.OtplessManager;
import com.otpless.main.OtplessView;

import org.json.JSONObject;

import java.util.HashMap;

public class MainActivity extends AppCompatActivity {
    OtplessView otplessView;
    TextView userName ;
    TextView userNumber ;
    private void onOtplessCallback(OtplessResponse response) {
        if (response.getErrorMessage() != null) {
            // todo error handing
        } else {
            final String token = response.getData().optString("token");
            final JSONObject otplessUser = response.getData();
            Toast.makeText(MainActivity.this, otplessUser.toString(), Toast.LENGTH_SHORT).show();
            String mobile=otplessUser.optString("mobile");
            String mobileName=null;
            String mobileNumber=null;
            try {
                HashMap<String,String> mobileHash= new ObjectMapper().readValue(mobile,HashMap.class);
                mobileName=mobileHash.get("name");
                mobileNumber=mobileHash.get("number");
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            userName.setText(mobileName);
            userNumber.setText(mobileNumber);
        }
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
         userName = findViewById(R.id.userName);
         userNumber = findViewById(R.id.userNumber);
        // Initialise OtplessView
        otplessView = OtplessManager.getInstance().getOtplessView(this);
        otplessView.setCallback(this::onOtplessCallback, null, false);
        // calling startOtpless method is optional to call here, we can also call it on buttons click

        Button loginButton = findViewById(R.id.loginButton);
        //This function will be used to trigger the OTPless floater
        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                otplessView.showOtplessLoginPage();
                // very important to call here, verification is done on low memory recreate case
                otplessView.verifyIntent(getIntent());
            }
        });
    }
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (otplessView != null) {
            otplessView.verifyIntent(intent);
        }
    }
    @Override
    public void onBackPressed() {
        // make sure you call this code before super.onBackPressed();
        if (otplessView.onBackPressed()) return;
        super.onBackPressed();
    }
}