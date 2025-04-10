class ForecastRepository
  CACHE_EXPIRATION = 30.minutes

  def self.for_zip(zip_code)
    return if zip_code.blank?

    cache_key = "forecast_zip_#{zip_code}"
    data = Rails.cache.read(cache_key)

    if data
      from_cache = true
    else
      data = yield
      Rails.cache.write(cache_key, data, expires_in: CACHE_EXPIRATION)
      from_cache = false
    end
    { data: data, from_cache: from_cache }
  end
end
