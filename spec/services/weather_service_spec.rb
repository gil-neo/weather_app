require 'rails_helper'

RSpec.describe WeatherService, type: :service do
  let(:coordinates) { [37.4221, -122.0841] }
  let(:fake_api_data) do
    {
      'main' => { 'temp' => 65, 'temp_max' => 70, 'temp_min' => 60 },
      'weather' => [{ 'description' => 'clear sky' }]
    }
  end

  describe 'get_current_forecast' do
    before do
      # Stub the call to the adapter
      adapter_instance = instance_double(WeatherApiAdapter)
      allow(WeatherApiAdapter).to receive(:new).and_return(adapter_instance)
      allow(adapter_instance).to receive(:fetch_current_weather).and_return(fake_api_data)
    end

    it 'returns a hash with temperature, high, low and description' do
      forecast = WeatherService.get_current_forecast(coordinates)
      expect(forecast).to include(
                            temperature: 65,
                            high: 70,
                            low: 60,
                            description: 'clear sky'
                          )
    end
  end
end
