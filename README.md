# Enterprise Weather Forecast Application

## Overview
This application accepts an address, retrieves current and extended weather forecasts, caches results by zip code for 30 minutes, and indicates if data is served from cache.

## Architecture
- **Adapters:** `WeatherApiAdapter` handles API communication.
- **Services:** `WeatherService` transforms raw API data.
- **Repositories:** `ForecastRepository` encapsulates caching behavior.
- **Controllers/Views:** Simple form and display logic with clear UX.

## Setup & Installation
1. Clone the repo.
2. Run `bundle install`.

## Testing
Run `bundle exec rspec` to execute the test suite.

## Environment Variables
- `OPENWEATHER_API_KEY`: API key used to access the weather API.

## Known Limitations
The code for fetching extended forecasts is implemented within WeatherService and integrated into the view. However, the current API key used does not support extended forecast calls. As a result, extended forecast data may not be displayed. This limitation is due solely to the API key permissions and not the implementation.

## Usage
1. Start the server with `rails server`.
2. Navigate to `http://localhost:3000/forecasts.
3. Enter an address and submit the form.
4. Cached results will be used for subsequent requests by zip code within a 30-minute window.

## Future Improvements
- Implement a more robust error handling mechanism.
- Automatically detect if the API key supports extended forecast functionality and show a friendly warning message if not.
- Use JavaScript/AJAX for a more dynamic user experience.
- Improve the UX/UI with better styling and layout.

## Scalability
- Use a dedicated caching store like Redis instead of memory store.
- Consider moving weather API refreshes to background jobs (using Sidekiq, Resque, or ActiveJob) so that client requests are not delayed by slow API calls.
- Implement rate limiting to avoid hitting API limits.

## Design Patterns
- Facade Pattern: Wraps complex API logic to simplify controller code.
- Adapter Pattern: Allows for swapping out the weather API with minimal changes.
- Repository Pattern: Encapsulates data access logic, making it easier to manage and test.

## Credits
Developed by Gilbert Rahme as a demonstration of Ruby on Rails capabilities in building a weather forecast application. The project showcases the use of service objects, repositories, and adapters to create a clean architecture.
