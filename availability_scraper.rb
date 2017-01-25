require 'csv'
require 'nokogiri'
require 'rest-client'

index = CSV.read("index.csv")
index.each_with_index do |row, row_idx|
  name_common = row[0]
  detail_url = row[1]
  puts "#{row_idx}/#{index.length}: #{name_common}"
  next if row_idx < 3831

  response = RestClient.get(detail_url)
  html_doc = Nokogiri::HTML(response.body)

  available = html_doc.text.include?('Buy Online Now')

  shop_url = nil
  price = nil

  if available
    shop_url = html_doc.css('.shop-icon').attr('href').value
    puts " - fetching price, #{shop_url}"

    begin
      shop_response = RestClient.get(shop_url)
      shop_html_doc = Nokogiri::HTML(shop_response.body)
      price = shop_html_doc.css('.product-shop-box')[0].css('.price-box').text.scan(/(?<=\$)[0-9\.]+/).map{|c| c.to_f}.max
    rescue RestClient::NotFound
      puts " - 404!"
    end
  end

  CSV.open("availability.csv", "ab") do |csv|
    csv << [available, shop_url, price]
  end
end