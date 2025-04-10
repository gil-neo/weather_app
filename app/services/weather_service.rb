class WeatherService
  def self.get_current_forecast(coordinates)
    lat, lon = coordinates
    adapter = WeatherApiAdapter.new(lat, lon)
    data = adapter.fetch_current_weather

    {
      temperature: data['main']['temp'],
      high: data['main']['temp_max'],
      low: data['main']['temp_min'],
      description: data['weather'][0]['description']
    }
  rescue StandardError => e
    Rails.logger.error("WeatherService Error: #{e.message}")
    {}
  end

  def self.get_extended_forecast(coordinates)
    lat, lon = coordinates
    adapter = WeatherApiAdapter.new(lat, lon)
    data = adapter.fetch_extended_forecast

    {
      current: data['current'],
      daily: data['daily']
    }
  rescue StandardError => e
    Rails.logger.error("Extended forecast error: #{e.message}")
    {}
  end
end
