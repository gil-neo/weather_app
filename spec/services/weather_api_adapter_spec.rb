require 'rails_helper'

RSpec.describe WeatherApiAdapter, type: :service do
  let(:lat) { 37.4221 }
  let(:lon) { -122.0841 }
  let(:adapter) { described_class.new(lat, lon) }
  let(:fake_current_response) do
    {
      'main' => { 'temp' => 65, 'temp_max' => 70, 'temp_min' => 60 },
      'weather' => [{ 'description' => 'clear sky' }]
    }
  end

  let(:fake_extended_response) do
    {
      'current' => { 'temp' => 65 },
      'daily' => [
        { 'temp' => { 'min' => 55, 'max' => 75 } },
        { 'temp' => { 'min' => 56, 'max' => 74 } }
      ]
    }
  end

  describe "#fetch_current_weather" do
    it "returns parsed response when successful" do
      # Stub the HTTParty get call
      allow(WeatherApiAdapter).to receive(:get)
                                    .with('/weather', query: hash_including(lat: lat, lon: lon))
                                    .and_return(double(success?: true, parsed_response: fake_current_response))

      expect(adapter.fetch_current_weather).to eq(fake_current_response)
    end

    it "raises an error when response is unsuccessful" do
      allow(WeatherApiAdapter).to receive(:get)
                                    .and_return(double(success?: false, parsed_response: { 'error' => 'fail' }))

      expect { adapter.fetch_current_weather }.to raise_error(StandardError)
    end
  end

  describe "#fetch_extended_forecast" do
    it "returns parsed response for extended forecast" do
      allow(WeatherApiAdapter).to receive(:get)
                                    .with('/onecall', query: hash_including(lat: lat, lon: lon))
                                    .and_return(double(success?: true, parsed_response: fake_extended_response))

      expect(adapter.fetch_extended_forecast).to eq(fake_extended_response)
    end
  end
end
