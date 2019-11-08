require "rails_helper"

RSpec.describe City, type: :model do
  it "Create a city" do
    city = City.create!(name: "City Name", code: '123456', lat: '23.23', lon: '23.23', country: 'RU')
    expect(city.name).to eq("City Name")
    expect(city.code).to eq(123456)
    expect(city.lon).to eq(23.23)
    expect(city.lat).to eq(23.23)
    expect(city.country).to eq('RU')
    expect(city.display).to eq(false)
  end
end

