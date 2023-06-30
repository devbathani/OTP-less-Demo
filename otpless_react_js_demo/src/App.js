import logo from "./otpless_icon.svg";
import "./App.css";
import { useEffect } from "react";

function App() {
  /*************************************** */
  // This function will be used to get the user data from the OTPless SDK
  /* ************************************* */
  useEffect(() => {
    window.otpless = (otplessUser) => {
      alert(JSON.stringify(otplessUser));
    };
  }, []);
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
      </header>
    </div>
  );
}

export default App;
