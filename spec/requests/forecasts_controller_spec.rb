require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "POST /forecast" do
    context "when address is blank" do
      it "renders the index template with a flash alert" do
        post forecasts_path, params: { address: "  " }
        expect(response).to have_http_status(:ok)
        # Expect the rendered response to include the flash message.
        expect(response.body).to include("Please enter an address.")
      end
    end

    context "when address is not found" do
      before do
        allow(Geocoder).to receive(:search).and_return([])
      end

      it "renders the index template with a flash.now alert" do
        post forecasts_path, params: { address: "Invalid Address" }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Address not found.")
      end
    end

    context "when address is valid" do
      let(:fake_location) do
        double("Location", coordinates: [37.4221, -122.0841], postal_code: "94043")
      end

      let(:fake_forecast) do
        { temperature: 65, high: 70, low: 60, description: "clear sky" }
      end

      before do
        allow(Geocoder).to receive(:search).and_return([fake_location])
        allow(WeatherService).to receive(:get_current_forecast).and_return(fake_forecast)
        Rails.cache.clear
      end

      it "assigns the forecast and renders the index template" do
        post forecasts_path, params: { address: "1600 Amphitheatre Parkway, Mountain View, CA" }
        expect(response).to have_http_status(:ok)
        # Check that the forecast data is visible in the response.
        expect(response.body).to include("65")
        expect(response.body).to include("clear sky")
      end
    end
  end

  describe "GET /forecasts" do
    it "renders the index page with the search form" do
      get forecasts_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Enter Address")
    end
  end
end
