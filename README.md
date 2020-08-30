### Ufa news

(https://ufanews.herokuapp.com)  

Приложение проводит сбор RSS feed региональных новостных веб-сайтов, подразделяет
с помощью двух нейронных сетей **Support Vector Machine (SVM)** (`gem 'libsvm'`)
и **Fast Artificial Neural (FANN)** (`gem 'fann'`) на 3 категории:

- «Дорожно-транспортные происшествия»;
- «Спорт»;
- «Власть».

![Скриншот веб-сайта](1_screenshot.png)

Используемые RSS-источники:
- Городской интернет-портал UTV.RU ([utv.ru/rss.xml](https://utv.ru/rss.xml));
- Российская Газета Башкортостан ([rg.ru/org/filial/bashkortostan/rss.xml](https://rg.ru/org/filial/bashkortostan/rss.xml));
- Коммерсантъ Уфа ([kommersant.ru/rss/regions/ufa_all.xml](https://www.kommersant.ru/rss/regions/ufa_all.xml)).  

Содержание папок:
- **1_analyze** (обучение нейросетей):
  - собранные новостные статьи;
  - анализ частот появления слов;
  - списки ключевых слов;
  - обучение нейросетей и тестирование их работы.
- **2_rails_project/ufa_news** (rails-приложение).



        
