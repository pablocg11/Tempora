# Tempora 🌍☀️

Tempora is a **SwiftUI-based** weather application built with Clean Architecture principles. It allows users to search for weather conditions in various cities, save cities to their favorites list, and store city data in a cache for quick access.

The app integrates with **OpenWeatherAPI/2.5** (which collects and processes weather data from various sources such as global and local weather models, satellites, radars, and a vast network of weather stations) and is limited to 1000 requests per day on the free plan.

# Features ✨

- **City Search**: Search for cities by name to view their weather conditions. 🌍
- **Location-based Default City**: The app now requests location permissions from users to automatically set their current city as the default city for weather updates. 🌍📍
- **Favorite Cities**: Add cities to a favorites list and check their weather at any time. ⭐
- **Weather Information**: Get detailed weather reports including temperature, description, and weather icons. 🌤️
- **Temperature Unit Toggle**: Switch between Celsius and Fahrenheit for temperature displays. 🌡️

# Tech Stack 🛠️

- **SwiftUI**: For building the user interface using declarative syntax. 🖥️
- **MVVM**: Architecture pattern used for separating concerns and improving testability. 🧹
- **Clean Architecture**: Ensures maintainability by following principles of separation of concerns. ⚙️
- **Async/Await**: Handles asynchronous network requests for fetching weather data. ⏳
- **SwiftData**: Used for persisting data, particularly for storing favorite cities and cached weather information. 🗄️
- **OpenWeatherAPI**: Fetches weather data from an external API to provide up-to-date information. 🌧️
- - **CoreLocation**: Requests location permissions from users to set their current city as the default for weather updates, leveraging the CoreLocation framework for accurate location services. 📍
- **Cache Layer**: Data is cached using a two-layer caching system (in-memory cache and persistent storage) for faster retrieval. 🔄
- **Dependency Injection**: Manages app components and services using Dependency Injection, ensuring flexibility and testability. ⚙️
