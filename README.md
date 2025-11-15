# Random Image Viewer

A simple Flutter app that shows a random image from an API and updates the background color to match the image’s dominant tone.  
Built with **Clean Architecture** and **BLoC** to keep the code organized and easy to extend.

---

### What it does
- Fetches a random image from the `/image` endpoint
- Displays it as a centered square with smooth fade-in
- Background color adapts to the image colors
- “Another” button loads a new image
- Handles loading and error states gracefully
- Works with light and dark themes

---

### Structure
The app follows a clean feature-based structure:

