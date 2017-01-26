require 'csv'


possible_zones = (1..12).to_a

plants_zones = []

index = CSV.read("details.csv").each do |row|
  zone_range_string = row[4]
  puts zone_range_string
  zone_range_values = zone_range_string.scan(/[0-9]/).map{|i| i.to_i}

  zone_range = []
  if zone_range_values.length == 1
    zone_range = zone_range_values
  else
    zone_range = (zone_range_values[0]..zone_range_values[1])
  end

  begin
    plant_zones = possible_zones.map{|z| zone_range.include?(z)}
  rescue
    plant_zones = []
  end
  plants_zones << plant_zones
end; 0


CSV.open("zones.csv", "wb") do |csv|
  plants_zones.each do |plant_zones|
    csv << plant_zones
  end
end