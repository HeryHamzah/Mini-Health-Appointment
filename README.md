
# Physiomobile

**Physiomobile** is a mini health appointment application that connects patients with therapists. Built with **Flutter**, it follows a **Clean Architecture** and uses the **BLoC Pattern** to ensure scalability and maintainability.

---

## 🔧 Technologies Used

- **Flutter** (with Clean Architecture + BLoC)
- **Firebase Auth** (for user authentication)
- **Firebase Firestore** (for storing appointments)
- **Flutter Secure Storage** (for securely storing session tokens)
- **Material Design 3** (dynamic theming support: light & dark mode)

---

## 🚀 Features

### 🔰 Landing Page
- Intro screen before login.

### 👤 Authentication
- **Register & Login** for patients.
- **Therapist Login** with predefined credentials:
  - `mustafa@gmail.com`
  - `tiara@gmail.com`
  - Password: `123456`
- **Auto-login** by securely saving the session token using `flutter_secure_storage`.

### 👨‍⚕️ Patient Features
- **Create Appointment**: Fill a form to schedule a new appointment (includes date and other details).
- **Upcoming Appointments**: View a list of future appointments.
- **Past Appointments**: View history of past appointments.
- **Profile Page**: Displays user information.

### 🩺 Therapist Features
- **Appointment List**: View all assigned appointments.
- **Edit Appointment Status**: Update appointment status to:
  - `new`, `pending`, `completed`, or `canceled`.

---

## 🎨 UI & Theming
- Follows **Material Design 3** principles.
- Theme adapts automatically based on device settings (light or dark mode).

---

## 📝 Developer Notes
- This app is developed for technical assessment purposes.
- Use the provided therapist accounts to explore therapist features.