class WeatherApiAdapter
  include HTTParty
  base_uri 'http://api.openweathermap.org/data/2.5'

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
    @api_key = ENV.fetch('OPENWEATHER_API_KEY')
    @units = 'imperial'
  end

  # Retrieves the current weather data.
  def fetch_current_weather
    response = self.class.get('/weather', query: { lat: @lat, lon: @lon, appid: @api_key, units: @units })
    raise StandardError, "Weather API error: #{response.parsed_response}" unless response.success?
    response.parsed_response
  end

  # Retrieves extended forecast data.
  def fetch_extended_forecast
    response = self.class.get('/onecall', query: { lat: @lat, lon: @lon, exclude: 'minutely,hourly', appid: @api_key, units: @units })
    raise StandardError, "Weather API error: #{response.parsed_response}" unless response.success?
    response.parsed_response
  end
end
