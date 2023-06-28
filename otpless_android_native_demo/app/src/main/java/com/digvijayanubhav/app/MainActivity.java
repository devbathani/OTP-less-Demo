package com.digvijayanubhav.app;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.otpless.views.OtplessManager;

import org.json.JSONObject;

import java.util.HashMap;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        OtplessManager.getInstance().init(this);
        OtplessManager.getInstance().showFabButton(false);
        Button loginButton = findViewById(R.id.loginButton);
        TextView userName = findViewById(R.id.userName);
        TextView userNumber = findViewById(R.id.userNumber);

        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                OtplessManager.getInstance().start(data -> {
                    if (data.getData() == null) {
                        Log.e("OTP-less", data.getErrorMessage());
                    } else {
                        final JSONObject otplessUser = data.getData();
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
                        final String token = otplessUser.optString("token");
                        if (!token.isEmpty()) {
                            Log.d("OTP-less", String.format("token: %s", token));
                            // todo send this token to your backend service to validate otplessUser details received in the callback with OTPless backend service
                        }
                    }
                });
            }
        });
    }
}