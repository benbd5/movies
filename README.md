# Flutter Movies and Watchlist App

Stay up to date on the latest movies and tv series with this Flutter application and save them in a watchlist.
The movies and tv series data is gotten from https://www.themoviedb.org/

<img src="https://github.com/user-attachments/assets/93cb969b-a077-4f3e-884c-6743b9d9839e" alt="movies_home" width="300"/>
<img src="https://github.com/user-attachments/assets/ede6f850-1189-4046-b7f9-6080084040e3" alt="search" width="300"/>
<img src="https://github.com/user-attachments/assets/84780a20-bb23-469e-ba5c-5c5438e3c178" alt="movie_details" width="300"/>
<img src="https://github.com/user-attachments/assets/78a5f0fb-9f1d-438f-a6e0-557a7a280d26" alt="liked" width="300"/>

## Features

- **Popular Movies**: View a list of popular movies.
- **Upcoming Movies**: See movies that will be released soon.
- **Now Playing Movies**: Check out movies that are currently in theaters.
- **Movie Details**: Get detailed information about each movie.
- **Search**: Search for movies using a floating action button.

## Installation

To run this project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/benbd5/movies.git
   cd movies
   ```
2. Add the .env file and add your TMDB API Key:
    ```bash
    cp .env.sample .env
    ```
    ```env
    // .env
    TMDB_API_KEY=your-api-key
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Run the app:
    ```bash
    flutter run
    ```

## Packages in use
[isar](https://pub.dev/packages/isar) for local database  
[http](https://pub.dev/packages/http) for handling API keys  
[cached_network_image](https://pub.dev/packages/cached_network_image) for caching images  
