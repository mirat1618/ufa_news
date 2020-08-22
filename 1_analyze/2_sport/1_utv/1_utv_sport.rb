require 'nokogiri'
require 'open-uri'

links = %w[
https://utv.ru/material/futbolnyj-klub-ufa-v-domashnem-matche-sygral-vnichyu-so-spartakom/
https://utv.ru/material/salavat-yulaev-na-starte-taneco-kubka-chempionov-ustupil-metallurgu/
https://utv.ru/material/kak-trener-ya-dovolen-priobreteniyami-glavnyj-trener-ufy-dal-ocenku-novichkam-komandy/
https://utv.ru/material/byvshij-glavnyj-trener-ufy-podelilsya-ozhidaniyami-ot-predstoyashej-igry-gorozhan-so-spartakom/
https://utv.ru/material/eks-igrok-salavata-yulaeva-prodolzhit-svoyu-kareru-v-zarubezhnom-chempionate/
https://utv.ru/material/vedushij-zashitnik-salavata-yulaeva-rasskazal-ob-osobennostyah-nyneshnej-predsezonki/
https://utv.ru/material/molodyozhka-salavata-yulaeva-primet-uchastie-v-predsezonnom-turnire/
https://utv.ru/material/eks-igrok-salavata-yulaeva-ne-smog-zakrepitsya-v-klube-khl/
https://utv.ru/material/hokkeist-molodyozhki-salavata-yulaeva-rasskazal-o-svoej-potere-v-sbornoj-rossii/
https://utv.ru/material/v-sbornuyu-2-go-tura-voshli-dva-predstavitelya-futbolnogo-kluba-ufa/
https://utv.ru/material/vospitannik-salavata-yulaeva-vernulsya-iz-za-granicy-v-rossiyu/
https://utv.ru/material/glavnyj-trener-salavata-podelilsya-mneniem-o-kubke-chempionov-v-kotorom-sygrayut-yulaevcy/
https://utv.ru/material/pokinuvshij-ufu-futbolist-rasskazal-kogda-debyutiruet-za-novuyu-komandu/
https://utv.ru/material/chempion-rossii-v-sostave-salavata-yulaeva-rasskazal-kak-izmenilsya-hokkej-za-poslednie-7-let/
https://utv.ru/material/vosem-igrokov-ufimskoj-hokkejnoj-komandy-treniruyutsya-v-sbornoj-rossii/
https://utv.ru/material/futbolnyj-klub-ufa-sushestvenno-uluchshil-svoyu-turnirnuyu-situaciyu/
https://utv.ru/material/byvshij-igrok-salavata-yulaeva-podpisal-probnyj-kontrakt-s-klubom-khl/
https://utv.ru/material/salavat-yulaev-mog-vozglavit-tryohkratnyj-obladatel-kubka-stenli/
https://utv.ru/material/futbolnyj-klub-ufa-na-vyezde-arsenal/
https://utv.ru/material/novichok-salavata-yulaeva-podelilsya-svoimi-vpechatleniyami-ot-ufy/
https://utv.ru/material/ufimskaya-komanda-pobedoj-zavershila-svoyo-vystuplenie-na-otkrytom-chempionate-samarskoj-oblasti/
https://utv.ru/material/sostav-ufimskoj-komandy-popolnil-igrok-zarubezhnoj-sbornoj/
https://utv.ru/material/razoril-federaciyu-za-bashkirskogo-sportsmena-byli-vyplacheny-milliony-dollarov/
https://utv.ru/material/salavat-yulaev-stal-10-kratnym-obladatelem-kubka-respubliki-bashkortostan/
https://utv.ru/material/salavat-yulaev-na-predsezonnom-turnire-severstal/
https://utv.ru/material/eks-igrok-salavata-yulaeva-prodolzhit-kareru-v-zarubezhnom-klube/
https://utv.ru/material/futbolnyj-klub-ufa-podtverdil-perehod-obladatelya-superkubka-rossii/
https://utv.ru/material/salavat-yulaev-poshyol-navstrechu-bolelshikam/
https://utv.ru/material/vospitannik-salavata-yulaeva-pobil-klubnyj-rekord-v-nhl/
https://utv.ru/material/trenerskij-shtab-futbolnogo-kluba-ufa-popolnilsya-novym-specialistom/
https://utv.ru/material/syn-dvukratnogo-chempiona-rossii-v-sostave-salavata-yulaeva-poshyol-po-stopam-otca/
https://utv.ru/material/hudshij-start-futbolnogo-kluba-ufa-v-premer-lige/
https://utv.ru/material/salavat-yulaev-lidiruet-na-kubke-respubliki-bashkortostan/
https://utv.ru/material/salavat-yulaev-na-svoyom-ldu-uverenno-obygral-neftehimik/
https://utv.ru/material/basketbol-vernulsya-v-ufu-v-stolice-bashkirii-proshli-vserossijskie-sorevnovaniya/
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