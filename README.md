# 💼 Career Genie Bot

AI-powered career assistant built with Flutter and Gemini 💙

## Overview

Career Genie is an intelligent career assistant built with Flutter that helps you find the best matching candidates from a list using natural language prompts. It uses Google's Gemini 2.0 Flash model to evaluate candidates based on skills, experience, and location.

## Features

- Search for candidates using natural language (e.g., "Flutter dev, 3 yrs, Delhi, testing expert")
- Automatic shortlisting of top 5 candidates based on skills, experience, and location
- Handles no-match scenarios gracefully
- Simple, beginner-friendly architecture using BLoC

## Getting Started

To run the app on your local machine, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jakansha2001/career-genie-bot

2. **Navigate to the project directory:**

   ```bash
   cd career_genie_bot

3. **Install dependencies:**

   Ensure all dependencies are installed by running:

   ```bash
   flutter pub get

4. **Setup environment variables:**

   Create a .env file in the root directory:

   ```bash
   GEMINI_API_KEY=your_gemini_api_key_here

5. **Run the app:**

   Use the following command to launch the app on an emulator or connected device:

   ```bash
   flutter run

## How it works

- User enters a prompt (e.g., "Flutter dev, 3 yrs, Delhi, testing expert").
- The app sends the prompt and candidate list to Gemini.
- Gemini returns the top 5 matching candidates.
- The UI updates with results or appropriate messages.

## Output

<p float="left">
  <img src="https://github.com/user-attachments/assets/f94869ed-c1b7-49f8-908c-8684fbede463" width="250" />
  <img src="https://github.com/user-attachments/assets/572071e6-7433-4283-aae5-e03f286b2c3b" width="250" />
  <img src="https://github.com/user-attachments/assets/b213cac3-a909-408c-bdf4-efa70dddf5fc" width="250" />
</p>

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or create a pull request on GitHub.
