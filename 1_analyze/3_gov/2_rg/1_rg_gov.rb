require 'nokogiri'
require 'open-uri'

links = %w[
https://rg.ru/2020/08/19/reg-pfo/vlasti-bashkirii-namereny-vykupit-kontrolnyj-paket-akcij-sodovoj-kompanii.html
https://rg.ru/2020/08/18/reg-pfo/v-bashkirii-shest-chelovek-osudiat-za-hishchenie-93-millionov-rublej.html
https://rg.ru/2020/07/10/reg-pfo/u-eks-zamministra-zhkh-bashkirii-nashli-imushchestvo-na-126-millionov.html
https://rg.ru/2020/07/02/reg-pfo/tourizm.html
https://rg.ru/2020/06/30/minstroj-obsuzhdaet-variant-provedeniia-kapremonta-kvartalov.html
https://rg.ru/2020/06/17/reg-pfo/pochemu-na-obsuzhdenie-genplana-ufy-ne-pustili-ego-razrabotchikov.html
https://rg.ru/2020/06/15/reg-pfo/zhiteliam-bashkirii-razreshili-ne-nosit-perchatki-v-magazinah-i-na-ulice.html
https://rg.ru/2020/06/11/reg-pfo/v-bashkirii-budut-shtrafovat-za-kurenie-kaliana-v-obshchestvennyh-mestah.html
https://rg.ru/2020/06/03/reg-pfo/prokuratura-bashkirii-obzhaluet-smiagchenie-prigovora-eks-policejskim.html
https://rg.ru/2020/05/29/reg-pfo/v-bashkirii-sozdadut-osobuiu-ekonomicheskuiu-zonu-alga.html
https://rg.ru/2020/05/27/reg-pfo/deputat-gosdumy-ot-bashkirii-rasskazal-chto-schitaet-svoej-krupnoj-pobedoj.html
https://rg.ru/2020/05/25/reg-pfo/minzdrav-bashkirii-prokommentiroval-zhalobu-zakrytyh-v-morge-medsester.html
https://rg.ru/2020/05/18/reg-pfo/v-ufe-budut-sudit-eks-sotrudnika-apparata-pravitelstva-bashkirii.html
https://rg.ru/2020/05/07/reg-pfo/v-bashkirii-deputaty-primut-zakon-o-tihom-chase.html
https://rg.ru/2020/05/03/reg-pfo/u-glavy-ispolkoma-edinoj-rossii-bashkirii-diagnostirovali-covid-19.html
https://rg.ru/2020/05/01/reg-pfo/v-ufe-sud-prigovoril-eksnachalnika-kolonii-k-lisheniiu-svobody.html
https://rg.ru/2020/04/21/reg-pfo/v-ufe-na-chinovnikov-merii-zaveli-ugolovnoe-delo-o-halatnosti.html
https://rg.ru/2020/04/16/reg-pfo/vlasti-bashkirii-utochnili-sroki-rezhima-samoizoliacii.html
https://rg.ru/2020/04/09/reg-pfo/v-bashkirii-vveli-komendantskij-chas-dlia-pozhilyh-i-detej.html
https://rg.ru/2020/04/08/reg-pfo/deputat-gosdumy-pavel-kachkaev-posovetoval-potrebiteliam-byt-aktivnee.html
https://rg.ru/2020/04/01/reg-pfo/v-bashkirii-ogranichili-vremia-prodazhi-alkogolia.html
https://rg.ru/2020/04/01/reg-pfo/v-ufe-deputat-gosdumy-rf-rasskazal-kak-pomogut-biznesu.html
https://rg.ru/2020/03/31/reg-pfo/v-bashkirii-vvedut-rezhim-polnoj-samoizoliacii.html
https://rg.ru/2020/03/30/reg-pfo/v-bashkirii-chinovnik-skryl-poezdku-v-dominikanu-i-vyshel-na-rabotu.html
https://rg.ru/2020/03/12/reg-bashkortostan/deputaty-bashkirii-podderzhali-popravki-v-konstituciiu-strany.html
https://rg.ru/2020/03/11/v-ufe-chinovnikov-nakazhut-za-sneg-i-gololed-vo-dvorah.html
https://rg.ru/2020/03/02/reg-pfo/minobrazovaniia-bashkirii-proverit-oskorbliaiushchuiu-detej-uchitelnicu.html
https://rg.ru/2020/02/12/reg-pfo/zhurnalist-rg-odin-den-porabotal-v-sisteme-incident-menedzhment.html
https://rg.ru/2020/01/21/reg-pfo/v-bashkirii-vpervye-glavoj-rajona-stala-zhenshchina.html
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