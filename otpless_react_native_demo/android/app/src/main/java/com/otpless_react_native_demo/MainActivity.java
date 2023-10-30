package com.digvijayanubhav.app;

import com.facebook.react.ReactActivity;
import com.facebook.react.ReactActivityDelegate;
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint;
import com.facebook.react.defaults.DefaultReactActivityDelegate;

import android.os.Bundle;
import com.otplessreactnative.OtplessReactNativeManager;
import android.content.Intent;

public class MainActivity extends ReactActivity {

@Override
protected void onCreate(Bundle savedInstanceState) {
 super.onCreate(savedInstanceState);
}
  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
    return "otpless_react_native_demo";
  }

  @Override
public void onNewIntent(Intent intent) {
	super.onNewIntent(intent);
	OtplessReactNativeManager.INSTANCE.onNewIntent(intent);
}

  @Override
public void onBackPressed() {
	if (OtplessReactNativeManager.INSTANCE.onBackPressed()) return;
	super.onBackPressed();
}

  /**
   * Returns the instance of the {@link ReactActivityDelegate}. Here we use a util class {@link
   * DefaultReactActivityDelegate} which allows you to easily enable Fabric and Concurrent React
   * (aka React 18) with two boolean flags.
   */
  @Override
  protected ReactActivityDelegate createReactActivityDelegate() {
    return new DefaultReactActivityDelegate(
        this,
        getMainComponentName(),
        // If you opted-in for the New Architecture, we enable the Fabric Renderer.
        DefaultNewArchitectureEntryPoint.getFabricEnabled());
  }
}
