# Mpesa App Clone 
## Introduction
The Mpesa App is a clone for the comprehensive mobile application for handling various financial transactions offered by Safaricom PLC. 
The app simulates how users send and request money, withdraw funds, buy airtime, and manage Mshwari loans and savings.
The app also provides a secure authentication system and supports both light and dark modes.

## Features
- Send Money: Transfer funds to other users quickly and securely.
- Request Money: Send money requests to other users and update balances seamlessly.
- Withdraw: Effortlessly withdraw funds from your Mpesa account.
- Buy Airtime: Purchase airtime directly through the app.
- Mshwari Loans and Savings: Access Mshwari loans and savings accounts with real-time balance updates.
- Global Pay: Convert entered amounts using the latest exchange rates.
- Authentication: Secure authentication with phone number OTP and fallback to Mpesa PIN if biometrics fail.
- Adaptive UI: Supports both light and dark modes for a better user experience.
- Spending Tracker: Track your spending and view detailed graphs of your expenses.

## Screenshots
### Main Views
<p>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/home.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/transact.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/services.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/grow.png", width="200" hspace="4"/>

</p>

### Transaction views
<p>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/send.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/pay.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/withdraw.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/airtime.png", width="200" hspace="4"/>
</p>

### Mshwari and Global Pay views

<p>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/mshwari.png", width="200" hspace="4"/>
   <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/globalPay.png", width="200" hspace="4"/>
  <img src="https://github.com/Huss3n/MpesaAppClone/blob/main/Screenshots/statements.png", width="200" hspace="4"/>
</p>

## Usage
1. Sign Up/Login: Use your phone number to sign up or log in.
2. Navigate: Use the menu to access different functionalities like sending money, requesting money, withdrawing funds, and buying airtime.
3. Manage Transactions: Track and manage your transactions through the app.


## Installation
To run this project locally, follow these steps:

1. Clone the repository
```
git clone https://github.com/Huss3n/MpesaAppClone
cd mpesa-app
```

2. Install dependencies
```
pod install
```
3. Set up Firebase
- Create a Firebase project on the  <a href="https://firebase.google.com"> Firebase Console.</a>
- Add your app's bundle ID to the Firebase project
- Download the GoogleService-Info.plist file from Firebase and place it in the project directory. Note that the app will crash without this file.
- Turn on the phone number Authentication and Firestore database on your google console for the storage and authentication of users.

4. Set up Exchange Rate API
- Sign up at <a href="https://www.exchangerate-api.com/"> Exchange Rate API</a> to get your API key.
- Add your Exchange Rate API key to the project on the file named Currency fetcher there is a var named apiKey
  ```
  let apiKey = "" 
  ```

5. Run the app

## Technologies Used
1. Swift, SwiftUI
2. Backend: Firebase (Firestore, Authentication)
3. APIs: Exchange Rate API for currency conversion
4. Security: Apple Local Authentication framework for biometrics and Mpesa PIN fallback

## Contributing
Contributions are welcome! Please follow these steps to contribute:
- Fork the repository.
- Create a new branch.
- Make your changes.
- Submit a pull request.

## Disclaimer
This app is a clone and is very similar to the real Mpesa app by Safaricom PLC. 
It is intended for educational purposes only. The functionality and user experience are designed to mimic the real app, but it is not affiliated with or endorsed by Safaricom PLC.

## Contact
For any questions or feedback, please contact me at aisakhussein0@gmail.com.











