require 'nokogiri'
require 'open-uri'

links = %w[
https://rg.ru/2020/08/19/reg-pfo/spartak-ne-smog-pereigrat-ufu-iz-za-nerealizovannogo-penalti.html
https://rg.ru/2020/08/16/reg-pfo/v-bashkirii-priostanovili-raboty-po-geologorazvedke-na-gore-kushtau.html
https://rg.ru/2020/07/12/reg-cfo/farfan-spas-lokomotiv-ot-porazheniia-v-matche-protiv-ufy.html
https://rg.ru/2020/07/05/reg-urfo/ural-upustil-pobedu-v-matche-protiv-ufy.html
https://rg.ru/2020/04/29/reg-pfo/smi-nikolaj-culygin-pokinet-post-glavnogo-trenera-hk-salavat-iulaev.html
https://rg.ru/2020/01/16/reg-urfo/tri-ochka-daciuka-prinesli-avtomobilistu-pobedu-nad-salavatom-iulaevym.html
https://rg.ru/2020/01/13/reg-pfo/vrachi-fk-ufa-spasli-passazhira-kotoromu-stalo-ploho-v-samolete.html
https://rg.ru/2020/01/06/reg-pfo/het-trik-hartikajnena-prines-salavatu-iulaevu-pobedu-nad-cska-v-khl.html
https://rg.ru/2019/12/07/reg-skfo/ahmat-proigral-ufe-v-matche-19-go-tura-rpl.html
https://rg.ru/2019/11/02/reg-cfo/lokomotiv-poterial-ochki-v-ufe.html
https://rg.ru/2019/10/20/reg-pfo/cska-upustil-pobedu-v-ufe.html
https://rg.ru/2019/10/03/reg-pfo/match-zvezd-associacii-studencheskogo-basketbola-projdet-v-ufe.html
https://rg.ru/2019/09/20/ufa-spartak-online.html
https://rg.ru/2019/09/16/reg-pfo/dinamo-i-ufa-golov-ne-zabili.html
https://rg.ru/2019/08/24/reg-pfo/ufa-zenit-onlajn-transliaciia-matcha-chempionata-rossii.html
https://rg.ru/2019/07/20/reg-pfo/krasnodar-oderzhal-volevuiu-pobedu-v-ufe.html
https://rg.ru/2019/06/09/reg-pfo/sbornaia-rossii-obygrala-italiancev-v-volejbolnoj-lige-nacij.html
]

nodes = %w[
.b-material-head__title
.b-material-wrapper__text
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