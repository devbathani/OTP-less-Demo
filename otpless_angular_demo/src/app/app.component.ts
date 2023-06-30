import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  /*************************************** */
  // This function is used to get the user data from the OTPless SDK
  /*************************************** */
  constructor() {
    //@ts-ignore
    window.otpless = (otplessUser) => {
      alert(JSON.stringify(otplessUser));
    };
  }

  title = 'otpless_angular_demo';
}
