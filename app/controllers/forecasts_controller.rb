class ForecastsController < ApplicationController

  def index
  end

  def create
    address = params[:address].strip

    if address.blank?
      flash[:alert] = "Please enter an address."
      return render :index
    end

    results = Geocoder.search(address)

    if results.blank?
      flash.now[:alert] = "Address not found."
      return render :index
    end

    # Use the first geocoded result.
    location = results.first
    coordinates = location.coordinates  # [lat, lon]
    zip_code = location.postal_code.presence

    @forecast = ForecastRepository.for_zip(zip_code) do
      WeatherService.get_current_forecast(coordinates)
    end

    # Fetch the extended forecast (e.g., a multi-day forecast)
    @extended_forecast = WeatherService.get_extended_forecast(coordinates)

    render :index
  end
end
