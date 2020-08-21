require 'nokogiri'
require 'open-uri'

links = %w[
https://rg.ru/2020/08/16/reg-pfo/v-bashkirii-inomarka-sbila-beremennuiu-zhenshchinu-s-rebenkom.html
https://rg.ru/2020/08/14/reg-pfo/v-ufe-tri-cheloveka-pogibli-v-massovom-dtp.html
https://rg.ru/2020/08/07/reg-pfo/v-ufe-dva-passazhirskih-vagona-poezda-soshli-s-relsov.html
https://rg.ru/2020/07/29/reg-pfo/v-bashkirii-zaveli-delo-posle-stolknoveniia-avtobusa-i-dvuh-gruzovikov.html
https://rg.ru/2020/07/28/reg-pfo/v-bashkirii-dva-cheloveka-pogibli-pri-stolknovenii-avtobusa-i-gruzovika.html
https://rg.ru/2020/07/22/reg-pfo/v-bashkirii-razrabotali-set-velomarshrutov.html
https://rg.ru/2020/07/18/reg-pfo/v-bashkirii-pod-kolesami-avtomobilia-pogib-10-letnij-velosipedist.html
https://rg.ru/2020/07/11/reg-pfo/v-bashkirii-mashina-skatilas-s-gory-i-protaranila-palatochnyj-lager.html
https://rg.ru/2020/07/11/reg-pfo/v-bashkirii-v-dtp-pogibli-tri-podrostka.html
https://rg.ru/2020/07/02/reg-pfo/v-bashkirii-vyroslo-kolichestvo-avarij-iz-za-netrezvyh-voditelej.html
https://rg.ru/2020/06/28/reg-pfo/v-ufe-v-rezultate-naezda-lexus-na-elektrooporu-pogibla-zhenshchina.html
https://rg.ru/2020/06/22/reg-pfo/v-bashkirii-benzovoz-stolknulsia-s-avtobusom-i-inomarkoj.html
https://rg.ru/2020/06/19/reg-pfo/v-bashkirii-pianyj-voditel-naehal-na-dvuh-devochek.html
https://rg.ru/2020/06/17/reg-pfo/v-bashkirii-arestovali-taksista-naehavshego-na-gruppu-podrostkov.html
https://rg.ru/2020/06/16/reg-pfo/v-bashkirii-pianyj-voditel-naehal-na-dvuh-devochek-i-pytalsia-ubezhat.html
https://rg.ru/2020/06/08/reg-pfo/v-bashkirii-voditelia-avtobusa-osudili-za-gibel-shesti-passazhirov.html
https://rg.ru/2020/04/14/v-bashkirii-pri-stolknovenii-gruzovika-i-avtomobilia-pogib-chelovek.html
https://rg.ru/2020/02/23/reg-pfo/v-bashkirii-v-massovom-dtp-pogibla-zhenshchina.html
https://rg.ru/2020/02/21/reg-bashkortostan/v-ufe-shest-chelovek-postradali-v-avarii-s-marshrutnym-avtobusom.html
https://rg.ru/2020/02/15/reg-pfo/v-bashkirii-pri-stolknovenii-inomarok-pogibli-dva-cheloveka.html
https://rg.ru/2020/01/19/reg-pfo/pod-ufoj-dva-cheloveka-pogibli-v-avarii-s-avtokranom.html
https://rg.ru/2020/01/18/reg-pfo/v-bashkirii-v-strashnoj-avarii-pogibli-tri-cheloveka.html
https://rg.ru/2020/01/18/reg-pfo/v-ufe-avtomobil-sbil-muzhchinu-s-rebenkom-na-rukah.html
https://rg.ru/2020/01/12/reg-pfo/v-bashkirii-pri-oprokidyvanii-avtomobilia-pogibla-devochka.html
https://rg.ru/2020/01/10/reg-pfo/v-ufe-stolknulis-passazhirskij-avtobus-i-kamaz.html
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