/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {View, StyleSheet, Text, Alert} from 'react-native';
import {OtplessModule} from 'otpless-react-native';
import {TouchableOpacity} from 'react-native';

const module = new OtplessModule();

module.showFabButton(false);

function whatsAppLogin() {
  // to start the sdk
  module.showLoginPage(data => {
    let message: string = '';
    if (data.data === null || data.data === undefined) {
      message = data.errorMessage;
    } else {
      console.log('Token :', data);
    }
  });
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
