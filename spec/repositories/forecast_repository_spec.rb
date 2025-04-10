# spec/repositories/forecast_repository_spec.rb
require 'rails_helper'

RSpec.describe ForecastRepository, type: :model do
  let(:zip_code) { '12345' }
  let(:fake_forecast) { { temperature: 65 } }

  before do
    Rails.cache.clear
  end

  context 'with valid zip_code' do
    it 'stores forecast data and returns not from cache on first call' do
      result = ForecastRepository.for_zip(zip_code) { fake_forecast }
      expect(result[:data]).to eq(fake_forecast)
      expect(result[:from_cache]).to be false
    end

    it 'retrieves forecast data from cache on subsequent calls' do
      # First call to populate the cache.
      ForecastRepository.for_zip(zip_code) { fake_forecast }
      # Second call should return the cached data even with a different yield block.
      result_cached = ForecastRepository.for_zip(zip_code) { { temperature: 100 } }
      expect(result_cached[:data]).to eq(fake_forecast)
      expect(result_cached[:from_cache]).to be true
    end
  end

  context 'with blank zip_code' do
    it 'returns nil' do
      result = ForecastRepository.for_zip('') { fake_forecast }
      expect(result).to be_nil
    end
  end
end
