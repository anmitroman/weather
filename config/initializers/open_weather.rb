yaml = YAML.load(File.read(Rails.root.join('config', 'secrets.yml')))
Rails.application.config.open_weather = {
  units: yaml["open_weather"]["units"],
  APPID: yaml["open_weather"]["APPID"]
}