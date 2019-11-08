namespace :setup do
  task :drop_database do
    puts "*** Drop old database ***"
    Rake::Task['db:drop'].invoke
  end
  task :create_database do
    puts "*** Create new database ***"
    Rake::Task['db:create'].invoke
  end
  task :migrate_database do
    puts "*** Do migrations ***"
    Rake::Task['db:migrate'].invoke
  end
  task :seed_database do
    puts "*** Seeding database ***"
    Rake::Task['db:seed'].invoke
  end
  desc "parse russian cities from cities list from http://bulk.openweathermap.org/sample/"
  task cities_parse: :environment do
    puts "*** parse russian cities from cities list from http://bulk.openweathermap.org/sample/ ***"
    zip_file_url = 'http://bulk.openweathermap.org/sample/city.list.min.json.gz'

    TEMP_FILE_NAME = 'city.list.gz'
    puts '*** Creating folders... ***'

    file_path = "#{Dir.tmpdir}/#{TEMP_FILE_NAME}"
    puts file_path
    puts '*** Downloading the file... ***'
    open(file_path, 'wb') do |file|
      open(zip_file_url) do |uri|
        file.write(uri.read)
      end
    end
    puts '*** Download complete. ***'
    puts '*** Unzipping the file... ***'
    gz = Zlib::GzipReader.new(open(file_path))
    output = gz.read
    cities_array = JSON.parse(output)
    puts '*** Unzipping complete. ***'
    puts '*** Parsing start... It takes some minutes... ***'

    cities_array.each_with_index do |city,i|
      if city["country"] == 'RU' 
        City.create(name: city["name"], code: city["id"], lon:city["coord"]["lon"], lat:city["coord"]["lat"], country: city["country"], display:false)
        puts city["name"] + ' - added to data base'
      end

    end
    puts '*** Parsing complete. ***'
    
  end
  task display_some_cities: :environment do
    puts '*** Display 10 cities at index. ***'
    City.first(10).each do |city|
      City.update(city['id'], display:true)
    end
    puts '*** Display complete. ***'
  end


end
task setup: :environment do
  
  Rake::Task['setup:drop_database'].invoke
  Rake::Task['setup:create_database'].invoke
  Rake::Task['setup:migrate_database'].invoke
  Rake::Task['setup:seed_database'].invoke
  Rake::Task['setup:cities_parse'].invoke
  Rake::Task['setup:display_some_cities'].invoke
  
end