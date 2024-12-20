
# TMDBMovies

## Overview
The Movie App is a Swift-based application that displays a list of "Now Playing" movies using the TMDB API. It supports user authentication via TMDB, allows users to bookmark movies, and caches bookmarked movies locally for offline access. The app is built following Clean Architecture principles and avoids the use of third-party libraries to ensure simplicity and transparency.

## Features
- **Display Now Playing Movies**: Fetch and display a list of currently playing movies from the TMDB API.
- **User Authentication**: Secure login using the TMDB API.
- **Bookmark Movies**: Allow users to bookmark their favorite movies.
- **Caching Mechanism**: Cache bookmarked movies for offline access.
- **Minimalistic Design**: Focused on simplicity and usability.

## Requirements
- **Swift**: Version 5 or later
- **Xcode**: Version 16 or later
- **Target Platform**: iPhone only (iOS 15+)
- **Architecture**: Clean Architecture (Separation of Concerns)
- **Third-Party Libraries**: None

## Project Structure
The project follows Clean Architecture principles:

- **Domain Layer**:
  - Defines core business logic and use cases.
  - Interfaces for repository and use case implementations.

- **Data Layer**:
  - Handles API calls to TMDB and data caching.
  - Provides repository implementations for the domain layer.

- **Presentation Layer**:
  - UI components and view controllers.
  - Handles user interaction and displays data from the domain layer.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/movie-app.git
   ```
2. Open the project in Xcode:
   ```bash
   cd movie-app
   open TMDBMovies.xcodeproj
   ```
3. Build and run the project on an iPhone simulator or physical device.

## Usage
1. Launch the app.
2. Log in using your TMDB account.
3. Browse "Now Playing" movies.
4. Tap on a movie to view details.
5. Bookmark your favorite movies for offline access.

## Technical Details
### TMDB API Integration
- **Endpoints Used**:
  - Now Playing Movies: `GET /movie/now_playing`
  - Authentication: `POST /authentication/token/new`
  - Movie Details: `GET /movie/{movie_id}`

### Caching
- Bookmarked movies are stored in an in-memory cache using a dictionary-based mechanism for simplicity and efficiency.
- Cache persists between app sessions.

### No Third-Party Libraries
- All network requests are implemented using `URLSession`.
- JSON decoding is performed using Swift’s built-in `Codable` protocol.

## Requirements for Contributors
- Ensure Swift 5 compatibility.
- Adhere to Clean Architecture principles.
- Avoid third-party libraries.
- Test changes on iPhone simulators (not compatible with iPads).

## Future Enhancements
- Add support for more TMDB endpoints, such as Top Rated or Popular Movies.
- Implement a more robust caching mechanism (e.g., local database).
- Enhance UI with animations and improved design.
- Add unit and integration tests.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---
