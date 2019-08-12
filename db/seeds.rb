# https://www.census.gov/population/www/censusdata/files/urpop0090.txt
Population.find_or_create_by(year: 1900) do |population|
  population.population = 76_212_168
end
Population.find_or_create_by(year: 1910) do |population|
  population.population = 92_228_496
end
Population.find_or_create_by(year: 1920) do |population|
  population.population = 106_021_537
end
Population.find_or_create_by(year: 1930) do |population|
  population.population = 123_202_624
end
Population.find_or_create_by(year: 1940) do |population|
  population.population = 132_164_569
end
Population.find_or_create_by(year: 1950) do |population|
  population.population = 151_325_798
end
Population.find_or_create_by(year: 1960) do |population|
  population.population = 179_323_175
end
Population.find_or_create_by(year: 1970) do |population|
  population.population = 203_302_031
end
Population.find_or_create_by(year: 1980) do |population|
  population.population = 226_542_199
end
Population.find_or_create_by(year: 1990) do |population|
  population.population = 248_709_873
end
