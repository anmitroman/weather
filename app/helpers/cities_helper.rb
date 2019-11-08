require 'open_weather'

module CitiesHelper
  STRFTIME_TEMPLATE = '%d.%m.%y'.freeze
  ERROR_MSG = 'Something is wrong. Contact site administrator, please'.freeze
  TAG = :h4

  def temperature(code)
    weather = Rails.cache.fetch("#{code}_weather", expires_in: 10.minutes) do
      OpenWeather::Current.city_id(code, Rails.application.config.open_weather)
    end

    return ERROR_MSG unless weather['main']
    
    "today, #{Date.today.strftime(STRFTIME_TEMPLATE)}: #{weather['main']['temp']}°"
  end

  def forecast(code)
    weather = Rails.cache.fetch("#{code}_forecast", expires_in: 10.minutes) do
      OpenWeather::Forecast.city_id(code, Rails.application.config.open_weather)
    end
    return unless weather['list']
     
    list = weather['list']
    day = Date.today
    tags = []
    
    list.first(3).each do |data|
      day = day.__send__(:next)

      info = <<-STR.squish
        #{day.strftime(STRFTIME_TEMPLATE)}: 
        #{data['weather'][0]['description']}, 
        #{data['main']['temp']}°
      STR

      tags << content_tag(TAG, info)
    end
    
    tags.join
  end

end
