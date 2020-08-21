require 'nokogiri'
require 'open-uri'

links = %w[
https://utv.ru/material/netrezvyj-voditel-v-tockom-rajone-orenburzhya-stolknulis-lob-v-lob-dva-avtomobilya/
https://utv.ru/material/sk-vozbudil-ugolovnoe-delo-po-faktu-smertelnogo-dtp-s-uchastiem-avtobusa/
https://utv.ru/material/v-orenburge-v-trojnom-dtp-postradal-3-letnij-rebenok/
https://utv.ru/material/v-bashkirii-na-trasse-stolknulis-dva-avtomobilya-odin-iz-voditelej-skonchalsya/
https://utv.ru/material/za-sutki-na-dorogah-bashkirii-v-avariyah-pogibli-pyat-chelovek/
https://utv.ru/material/v-ufe-vinovnika-dtp-v-kotorom-pogibli-tri-cheloveka-otpravili-v-sizo-na-dva-mesyaca/
https://utv.ru/material/vyskochila-otkuda-voditelnica-sbivshaya-na-perehode-zhenshinu-s-rebyonkom-rasskazala-o-dtp/
https://utv.ru/material/video-v-ufe-mashina-sbila-na-zebre-zhenshinu-s-rebyonkom/
https://utv.ru/material/v-ufe-porsche-cayenne-vrezalsya-v-stenu-torgovogo-pavilona/
https://utv.ru/material/video-v-ufe-v-avarii-na-ulice-sochinskoj-pogibli-3-cheloveka-vinovnik-dtp-byl-pyan/
https://utv.ru/material/na-trasse-orenburg-orsk-proizoshlo-smertelnoe-dtp/
https://utv.ru/material/nesovershennoletnij-bajker-sbil-dvuh-peshehodov-pod-orenburgom/
https://utv.ru/material/v-ufe-muzhchina-chut-ne-ugrobil-svoih-passazhirov-vletev-v-metallicheskij-zabor/
https://utv.ru/material/v-bashkirii-v-dtp-postradali-chetyre-cheloveka-v-tom-chisle-malenkij-malchik/
https://utv.ru/material/v-bashkirii-semejnaya-para-skonchalas-v-dtp/
https://utv.ru/material/v-orsk-v-dtp-serezno-postradal-passazhir/
https://utv.ru/material/v-odnom-iz-ufimskih-dvorov-sbili-rebyonka-kotoryj-igral-na-trotuare/
https://utv.ru/material/v-bashkirii-za-sutki-nasmert-sbili-dvoih-peshehodov/
https://utv.ru/material/na-trasse-kazan-orenburg-v-dtp-pogibla-5-letnyaya-devochka/
https://utv.ru/material/gibdd-bashkirii-prosit-otkliknutsya-ochevidcev-smertelnogo-dtp/
https://utv.ru/material/v-ufe-skonchalsya-63-letnij-muzhchina-kotorogo-sbili-na-ulice-pugacheva/
https://utv.ru/material/v-orenburge-na-peshehodnom-perehode-sbili-12-letnyuyu-devochku-na-velosipede/
https://utv.ru/material/na-trasse-samara-orenburg-legkovushka-vletela-v-kamaz/
https://utv.ru/material/na-trasse-orenburg-orsk-pogib-peshehod/
https://utv.ru/material/largus-protiv-motocikla-stali-izvestny-sereznogo-dtp-v-orenburge/
https://utv.ru/material/v-bashkirii-voditel-vaz-2114-sehal-v-kyuvet-oprokinul-avtomobil-i-skonchalsya-na-meste/
https://utv.ru/material/v-centre-ufy-avtomobil-naehal-na-peshehoda-perehodyashego-dorogu-po-zebre/
https://utv.ru/material/ufimec-sbil-pozhilogo-velosipedista-pomog-emu-podnyatsya-i-skrylsya-s-mesta-dtp/
https://utv.ru/material/v-orenburge-v-avarii-s-uchastiem-avtobusov-postradali-passazhiry/
https://utv.ru/material/na-trasse-v-orenburzhe-pogib-voditel-shevrole-niva/
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