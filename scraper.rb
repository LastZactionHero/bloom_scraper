require 'csv'
require 'rest-client'
require 'nokogiri'

('A'..'Z').to_a.each do |letter|
  puts "Letter: #{letter}"
  page_idx = 1
  while true do
    puts "Page: #{page_idx}"
    url = "http://www.monrovia.com/plant-catalog/search/?start_page=#{page_idx}&common_name=#{letter}&botanical_name=&sort_by=common_name"
    response = RestClient.get(url)

    # End of list
    break if response.body.include?('Sorry, your search yielded no results.')

    html_doc = Nokogiri::HTML(response.body)

    html_doc.css('.list-plant').each do |node|
      common_name = node.css('a')[2].text
      details_url = node.css('a')[0].attr('href')

      CSV.open("index.csv", "ab") do |csv|
        csv << [common_name, details_url]
      end
    end

    page_idx += 1
  end
end
