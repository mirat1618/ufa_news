require 'nokogiri'
require 'open-uri'

links = %w[
https://www.kommersant.ru/doc/4459531
https://www.kommersant.ru/doc/4459512
https://www.kommersant.ru/doc/4459313
https://www.kommersant.ru/doc/4458645
https://www.kommersant.ru/doc/4458373
https://www.kommersant.ru/doc/4457135
https://www.kommersant.ru/doc/4451672
https://www.kommersant.ru/doc/4440549
https://www.kommersant.ru/doc/4435130
https://www.kommersant.ru/doc/4434103
https://www.kommersant.ru/doc/4425483
https://www.kommersant.ru/doc/4425275
https://www.kommersant.ru/doc/4424810
https://www.kommersant.ru/doc/4424491
https://www.kommersant.ru/doc/4416660
https://www.kommersant.ru/doc/4416729
https://www.kommersant.ru/doc/4398412
https://www.kommersant.ru/doc/4398612?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4366516?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4423461?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4417246?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4104235?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4407943?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4283403?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4067338?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4072446?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4459680?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4274945?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4408083?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4405913?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4274155?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4140534?query=%D1%84%D0%BA%20%D1%83%D1%84%D0%B0
https://www.kommersant.ru/doc/4335399?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4221369?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4173626?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4327686?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4357658?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4189816?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4219077?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4242950?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4267624?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4269799?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
https://www.kommersant.ru/doc/4283839?query=%D1%81%D0%B0%D0%BB%D0%B0%D0%B2%D0%B0%D1%82%20%D1%8E%D0%BB%D0%B0%D0%B5%D0%B2
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