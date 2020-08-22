require 'nokogiri'
require 'open-uri'

links = %w[
            https://utv.ru/rss.xml
]

links.each do |link|
  doc = Nokogiri::XML(open(link))
  items = doc.xpath('//channel//item')
  items.each do |item|
    title_raw = item.css('title').text
    title = title_raw.split.join(' ')

    description_raw = item.css('description').text
    description = description_raw.split.join(' ')

    link = item.css('link').text
  end
end