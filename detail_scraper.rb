require 'csv'
require 'nokogiri'
require 'rest-client'

def scrape_text
  begin
    yield
  rescue NoMethodError
    'Undefined'
  end
end

index = CSV.read("index.csv")
index.each_with_index do |row, row_idx|
  name_common = row[0]
  detail_url = row[1]
  puts "#{row_idx}/#{index.length}: #{name_common}"

  response = RestClient.get(detail_url)
  html_doc = Nokogiri::HTML(response.body)

  thumbnail           = scrape_text{html_doc.css('.slide-a').css('img').attr('src').value}
  name_scientific     = scrape_text{html_doc.css('.plant-main-right').css('h2').text}
  zones               = scrape_text{html_doc.css('span').find{|s| s.text.include?('USDA Hardiness Zone')}.css('a').text}
  description         = scrape_text{html_doc.css('.plant-description').css('p').text}
  light_needs         = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Light Needs')}.parent.css('div')[1].text}
  watering_needs      = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Watering Needs')}.parent.css('div')[1].text}
  average_size        = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Average Landscape Size')}.parent.css('div')[1].text}
  key_feature         = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Key Feature')}.parent.css('div')[1].text}
  blooms              = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Blooms')}.parent.css('div')[1].text}
  landscape_uses      = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Landscape Uses')}.parent.css('div')[1].text}
  plant_type          = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Plant type')}.parent.css('span')[1].text}
  deciduous_evergreen = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Deciduous/evergreen')}.parent.css('span')[1].text}
  growth_rate         = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Growth rate')}.parent.css('span')[1].text}
  special_features    = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Special features')}.parent.css('span')[1].text}
  foliage_color       = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Foliage color')}.parent.css('span')[1].text}
  blooms              = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Blooms')}.parent.css('span')[1].text}
  flower_color        = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Flower color')}.parent.css('span')[1].text}
  flower_attributes   = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Flower attributes')}.parent.css('span')[1].text}
  garden_style        = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Garden style')}.parent.css('span')[1].text}
  companion_plants    = scrape_text{html_doc.css('.label').find{|n| n.text.include?('Companion Plants')}.parent.css('span')[1].text}
  care                = scrape_text{html_doc.css('.care').text}

  CSV.open("details.csv", "ab") do |csv|
    csv << [
      name_common,
      detail_url,
      name_scientific,
      thumbnail,
      zones,
      description,
      light_needs,
      watering_needs,
      average_size,
      key_feature,
      blooms,
      landscape_uses,
      plant_type,
      deciduous_evergreen,
      growth_rate,
      special_features,
      foliage_color,
      blooms,
      flower_color,
      flower_attributes,
      garden_style,
      companion_plants,
      care
    ]
  end
end
