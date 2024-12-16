#!/bin/bash

# Function to display messages
function echo_message() {
    echo -e "\n\033[1;32m$1\033[0m\n"
}

# Step 1: Prompt to create Vite + React app interactively
echo_message "Launching Vite's interactive setup."
npm create vite@latest

# Get the project name from the folder created by Vite
read -p "Enter the project folder name created by Vite: " PROJECT_NAME

# Check if the directory exists
if [ ! -d "$PROJECT_NAME" ]; then
    echo "Project folder does not exist. Exiting."
    exit 1
fi

cd $PROJECT_NAME || exit

# Step 2: Remove default code from src folder
echo_message "Cleaning default Vite + React code"
rm -rf src/*
touch src/index.css src/main.jsx src/App.jsx

# Step 3: Install Tailwind CSS
echo_message "Installing Tailwind CSS and related dependencies"
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Step 4: Configure Tailwind
echo_message "Configuring Tailwind CSS"
cat <<EOT > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOT

# Step 5: Setup src/index.css with Tailwind imports
cat <<EOT > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOT

# Step 6: Setup basic structure in src/main.jsx and src/App.jsx
echo_message "Setting up basic file structure"
cat <<EOT > src/main.jsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOT

cat <<EOT > src/App.jsx
function App() {
  return (
    <div className="h-screen flex items-center justify-center">
      <h1 className="text-4xl font-bold text-blue-600">Hello, Tailwind with Vite + React!</h1>
    </div>
  );
}

export default App;
EOT

# Step 7: Run the project
echo_message "Installation complete! Running the development server..."
npm install
npm run dev
