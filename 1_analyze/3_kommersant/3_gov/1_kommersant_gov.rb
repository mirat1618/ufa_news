require 'nokogiri'
require 'open-uri'

links = %w[
https://www.kommersant.ru/doc/4341989?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4458384?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4377706?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4397257?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4189056?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4364310?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4399268?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4441568?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4458259?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4458277?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4252737?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4358209?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4458095?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4087929?query=%D1%85%D0%B0%D0%B1%D0%B8%D1%80%D0%BE%D0%B2
https://www.kommersant.ru/doc/4292044?query=%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B1%D0%B0%D1%88%D0%BA%D0%BE%D1%80%D1%82%D0%BE%D1%81%D1%82%D0%B0%D0%BD
https://www.kommersant.ru/doc/4450589?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4348583?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4351060?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4450138?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4196704?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4195681?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4301741?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4096707?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4214021?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4140879?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4342894?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4457661?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4354971?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4358842?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4119761?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4347924?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
https://www.kommersant.ru/doc/4377844?query=%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE%20%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F
]

nodes = %w[
.article_name
.article_text_wrapper
]

links.each_with_index do |link, index|
  file = File.new("#{index}.txt", 'w')
  doc = Nokogiri::HTML(open(link), nil, Encoding::UTF_8.to_s)
  nodes.each do |node|
    doc.css(node).each do |tag|
      p tag.content
      file.write("#{tag.text}\n")
    end
  end
  file.close
end