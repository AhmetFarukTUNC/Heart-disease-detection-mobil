## Heart Disease Prediction Mobile App
# Project Overview

This project is a mobile application that predicts the risk of heart disease using machine learning. Users can register, log in, and fill out their health data through a form. The app then sends this data to a Flask API, which returns a prediction. All predictions are stored in a MySQL database using a PHP backend, and users can view their medical reports.

# Features

# User Authentication

Registration and login functionality.

Each user has a unique ID to track their health data.

# Heart Disease Prediction

Users enter health parameters: age, sex, chest pain type, blood pressure, cholesterol, fasting blood sugar, resting ECG, max heart rate, exercise angina, oldpeak, ST slope.

Data is sent to a Flask API that processes it using a trained Random Forest model.

Prediction results are returned instantly.

# Medical Reports

All past predictions are stored in a MySQL database.

Users can view a list of their previous reports in a friendly, easy-to-read format.

Prediction results are displayed clearly as either “High Risk” or “Low Risk”.

# Backend

Flask API handles machine learning inference.

PHP scripts manage database storage.

MySQL database keeps user info and prediction history.

# User Interface

Flutter mobile app with modern design.

Gradient buttons, cards, and icons for better UX.

Detailed medical report page for each prediction.

Technology Stack

Mobile App: Flutter (Dart)

API: Flask (Python)

Machine Learning: Scikit-learn (Random Forest)

Database: MySQL

Backend Storage: PHP

CORS Handling: Flask-CORS

Installation & Setup

## Clone the repository

git clone https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/
cd Heart-disease-detection-mobil

## Flutter App

Install Flutter SDK.

Run:

flutter pub get
flutter run

## Flask API

Install dependencies:

pip install flask numpy scikit-learn joblib flask-cors

Place random_forest_model.pkl and encoders.pkl in the API folder.

Run:

python app.py

PHP Backend

Configure save_heart_data.php with your MySQL credentials.

Ensure heart_data_api.php and save_heart_data.php are reachable from Flutter.

Database

Create MySQL database heart_health_mobil.

Create table heart_data with columns:

id, userId, Age, Sex, ChestPainType, RestingBP, Cholesterol,
FastingBS, RestingECG, MaxHR, ExerciseAngina, Oldpeak, ST_Slope,
Prediction, created_at,Name

Usage

Register or log in to the app.

Fill out the heart disease form with your health data.

Tap Predict to get your risk assessment.

View your predictions in the Medical Report page.

Notes

Ensure your Flask API and PHP backend URLs are accessible from the device/emulator.

Predictions are based on the Random Forest model; results are for informational purposes and not a medical diagnosis.

License

This project is for educational purposes. All rights reserved by the developer.

![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/1.png))

![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/2.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/3.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/4.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/5.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/6.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/7.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/8.png))
![Uygulama Ana Sayfa]((https://github.com/AhmetFarukTUNC/Heart-disease-detection-mobil/blob/main/img/1.png))

