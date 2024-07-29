# Mango: A Dietary Preferences Suitability App

## Project Overview

This mobile application is designed to help users with dietary restrictions and preferences quickly determine the suitability of food items. By using image recognition technology to analyse product labels, the app provides near-instant feedback on whether an item is consumable based on the user's dietary needs.

## Features

- **Optical Character Recognition (OCR)**: Scans product labels to extract text.
- **Database Integration**: Accesses a comprehensive database with ingredient information.
- **User Preferences**: Allows users to set dietary preferences and restrictions.
- **Real-Time Feedback**: Provides immediate feedback on the suitability of food items.
- **User-Friendly Interface**: Designed for ease of use with a clear and intuitive interface.

## Technologies Used

- **Swift**: The primary programming language used for developing the iOS application.
- **Xcode**: The integrated development environment (IDE) for Swift.
- **VisionKit**: For image analysis and text recognition.
- **GitHub**: For version control and collaboration.

## Installation

1. **Clone the Repository**

   ```
   git clone https://github.com/albrechtluke/mango.git
   ```

2. **Open the Project in Xcode**

   ```
   cd mango
   open SDDProject.xcodeproj
   ```
   
3. **Install Dependencies**
Ensure you have all the necessary dependencies installed. You might need to update your project settings or dependencies through Xcode.

4. **Run the Application**
Select a simulator or connect a physical device and click the "Run" button in Xcode.

## Usage

1. Setting Preferences
Open the 'List' page and select the settings icon on the top right of the screen
Set your dietary preferences and restrictions.
Exit out of the page to save your preferences. 

2. Scanning Products
Use the camera feature to scan the barcode or product label.
The app will process the image and provide feedback on the item's suitability.

3. Viewing Results
The results page will show if the product is suitable for your dietary needs.
Click through for a detailed breakdown of the ingredients.

4. Historical Results
The History page will show all past products scanned and suitability at a glance. 
Click through for a detailed breakdown of the ingredients.
