/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {View, StyleSheet, Text, Alert} from 'react-native';
import {NativeModules, NativeEventEmitter} from 'react-native';
const {OtplessModule} = NativeModules;
import {TouchableOpacity} from 'react-native';

function whatsAppLogin() {
  // to show OTPLESS popup
  OtplessModule.startOtplessWithEvent();
  // to receive otplessUser details and token
  const eventListener = new NativeEventEmitter(OtplessModule).addListener(
    'OTPlessSignResult',
    result => {
      if (result.data == null || result.data === undefined) {
        let error = result.errorMessage;
        console.log('error', error);
      } else {
        // const token = result.data.token;
        console.log('data', result.data);
        const jsonObject = result.data;

        const jsonString = JSON.stringify(jsonObject);

        Alert.alert('User Data', jsonString, [
          {text: 'OK', onPress: () => console.log('OK Pressed')},
        ]);
        // send this token to your backend to validate user details
        // setOtplessResult(token);
      }
    },
  );
  // call this method when you login is completed
  OtplessModule.onSignInCompleted();
}
function App(): JSX.Element {
  return (
    <View style={styles.container}>
      <TouchableOpacity style={styles.button} onPress={whatsAppLogin}>
        <Text style={styles.buttonText}>Login</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  button: {
    backgroundColor: 'blue',
    padding: 10,
    borderRadius: 5,
    marginTop: 50,
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    textAlign: 'center',
  },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    margin: 10,
  },
  row: {
    flexDirection: 'row',
    margin: 10,
  },
  widget: {
    width: 200,
    height: 50,
    backgroundColor: 'lightblue',
    margin: 10,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default App;
