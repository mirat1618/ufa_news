require 'nokogiri'
require 'open-uri'

links = %w[
https://utv.ru/material/chem-zakonchilas-vstrecha-radiya-habirova-i-zashitnikov-shihana-kushtau/
https://utv.ru/material/glava-ishimbajskogo-rajona-o-mitinge-eto-zaplanirovannaya-i-produmannaya-akciya/
https://utv.ru/material/glava-bashkirii-planiruet-vykupit-kontrolnyj-paket-akcij-bsk/
https://utv.ru/material/premer-ministr-rossii-mihail-mishustin-predlozhil-vernut-romantiku-sovetskih-vremen-na-kamchatku/
https://utv.ru/material/v-bashkirii-chinovnikov-i-policejskih-osudyat-za-mnogomilionnuyu-krazhu/
https://utv.ru/material/vice-premer-azat-badranov-rasskazal-o-vstreche-habirova-s-zashitnikami-kushtau-v-bashkirii/
https://utv.ru/material/eto-prosto-krasivaya-gora-ne-bolee-radij-habirov-o-svoem-otnoshenii-k-kushtau/
https://utv.ru/material/skolko-chinovniki-bashkirii-zarabotali-za-2019-god/
https://utv.ru/material/glava-bashkirii-vvel-rezhim-chs-v-rajonah-respubliki/
https://utv.ru/material/aleksej-venediktov-hochet-priehat-v-bashkiriyu-chtoby-pogovorit-s-radiem-habirovym-po-povodu-kushtau/
https://utv.ru/material/rekonstrukciya-stroenij-ryadom-s-domom-respubliki-obojdetsya-v-4-milliona-rublej/
https://utv.ru/material/vlasti-bashkirii-prokommentirovali-skandalnoe-vyskazyvanie-chinovnicy-pro-bezrabotnyh/
https://utv.ru/material/v-ufe-sud-obyazal-chinovnikov-snesti-10-avarijnyh-domov/
https://utv.ru/material/v-orenburge-nachalsya-sud-po-isku-prokuratury-v-otnoshenii-ministra-finansov-tatyany-moshkovoj-i-ee-/
https://utv.ru/material/ministr-zdravoohraneniya-orenburzhya-rasskazala-ob-otkrytii-shkol-i-detskih-sadov/
https://utv.ru/material/u-ministra-semi-i-truda-bashkirii-poyavilsya-shestoj-zamestitel/
https://utv.ru/material/ministr-zdravoohraneniya-orenburzhya-rasskazala-o-sostoyanii-detej-s-koronavirusom/
https://utv.ru/material/administraciya-orenburga-vyplatit-dolgi-na-16-millionov-za-kapremont/
https://utv.ru/material/gorprokuratura-vyyavila-9-narushenij-pri-vydache-porubochnyh-biletov-v-administracii-orenburga/
https://utv.ru/material/sud-obyazal-administraciyu-abdulino-otremontirovat-dorogi/
https://utv.ru/material/administracii-hajbullinskogo-rajona-ponadobilsya-shikarnyj-dvuhetazhnyj-osobnyak/
https://utv.ru/material/ministr-zdravoohraneniya-rossii-priehal-v-ufu-na-otkrytie-kliniki-dlya-bolnyh-koronavirusom/
https://utv.ru/material/ministr-obrazovaniya-rasskazal-chto-budet-v-produktovyh-naborah-dlya-orenburgskih-shkolnikov/
https://utv.ru/material/byvshij-ministr-zdravoohraneniya-rossiya-vyshla-na-plato-po-covid-19/
https://utv.ru/material/ministr-zdravoohraneniya-bashkirii-poobeshal-udalyat-negativnye-kommentarii-v-svoj-adres/
https://utv.ru/material/skonchalsya-byvshij-glava-novotroicka-yurij-araskin/
https://utv.ru/material/glava-bashkirii-planiruet-vykupit-kontrolnyj-paket-akcij-bsk/
https://utv.ru/material/glava-bashkirii-pozdravil-zheleznodorozhnikov-s-ih-professionalnym-prazdnikom/
https://utv.ru/material/pomoshnik-glavy-orenburga-natalya-sablina-uvolnyaetsya-ne-otrabotav-i-mesyac/
https://utv.ru/material/obvinenie-trebuet-dlya-eks-glavy-orenburga-arapova-10-let-kolonii-strogo-rezhima/
https://utv.ru/material/glava-bashkirii-sprosil-mnenie-zhitelej-o-budushem-pamyatnike/
https://utv.ru/material/eks-glava-selsoveta-v-bashkirii-narushil-pravila-zakupok/
https://utv.ru/material/eks-nachalniku-uodd-orenburga-sergeyu-proshinu-prodlili-domashnij-arest/
https://utv.ru/material/v-bashkirii-razreshili-znachitelno-uvelichit-kolichestvo-chinovnikov/
https://utv.ru/material/ufimka-razyskivaet-mera-goroda-ulfata-mustafina/
https://utv.ru/material/v-bashkirii-na-vertolyote-gonyali-korov-po-polyu-predpolozhitelno-pilotom-byl-otec-krupnogo-chinovni/
https://utv.ru/material/zamministra-stroitelstva-i-dorozhnogo-hozyajstva-orenburzhya-dmitrij-aniskov-podal-v-otstavku/
https://utv.ru/material/deputat-obnaruzhila-ischezayushie-chernila-v-schyote-za-remont-liftov/
https://utv.ru/material/iskali-s-fakelami-glava-bashkirii-otchital-chinovnika-za-chto-sutki-ne-vyhodil-na-svyaz/
]

nodes = %w[
    .container-item__title
    .container-item__shortland
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