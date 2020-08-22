require 'nokogiri'
require 'open-uri'

links = %w[
https://www.kommersant.ru/doc/4250551?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4372897?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4434051?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4242454?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4259014?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4432997?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4142961?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4142224?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4119836?query=%D0%B1%D0%B0%D1%88%D0%BA%D0%B8%D1%80%D0%B8%D1%8F%20%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4343606?query=%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4342799?query=%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4344184?query=%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4342413?query=%D0%B4%D1%82%D0%BF
https://www.kommersant.ru/doc/4450764?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4094540?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4456835?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4119836?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4171657?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4434051?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4181536?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4336970?query=%D0%B4%D1%82%D0%BF%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4135065?query=%D0%B3%D0%B8%D0%BB%D1%8C%D0%BC%D1%83%D1%82%D0%B4%D0%B8%D0%BD%D0%BE%D0%B2%20%D0%B4%D0%B8%D0%BD%D0%B0%D1%80
https://www.kommersant.ru/doc/4315878?query=%D0%B3%D0%B8%D0%BB%D1%8C%D0%BC%D1%83%D1%82%D0%B4%D0%B8%D0%BD%D0%BE%D0%B2%20%D0%B4%D0%B8%D0%BD%D0%B0%D1%80
https://www.kommersant.ru/doc/4321639?query=%D0%B3%D0%B8%D0%BB%D1%8C%D0%BC%D1%83%D1%82%D0%B4%D0%B8%D0%BD%D0%BE%D0%B2%20%D0%B4%D0%B8%D0%BD%D0%B0%D1%80
https://www.kommersant.ru/doc/4434051?query=%D0%B3%D0%B8%D0%BB%D1%8C%D0%BC%D1%83%D1%82%D0%B4%D0%B8%D0%BD%D0%BE%D0%B2%20%D0%B4%D0%B8%D0%BD%D0%B0%D1%80
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