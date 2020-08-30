require 'nokogiri'
require 'open-uri'
require 'neural_nets/svm_recognizer'
require 'neural_nets/fann_recognizer'
require 'neural_nets/text_processable'

def scrape
  include SVM
  include FANN
  svm = SVM::SVMRecognizer.new("#{Rails.root}/lib/neural_nets/trained_models/1_svm/")
  fann = FANN::FANNRecognizer.new("#{Rails.root}/lib/neural_nets/trained_models/2_fann/")
  sources = {
      'UTV' => {
          url: 'https://utv.ru/rss.xml',
          nodes: {
              title: '.container-item__title',
              content: '.wrap'
          }
      },
      'Российская Газета' => {
          url: 'https://rg.ru/org/filial/bashkortostan/rss.xml',
          nodes: {
              title: 'h1.b-material-head__title',
              content: '.b-material-wrapper__text p'
          }
      },
      'Коммерсантъ' => {
          url: 'https://kommersant.ru/rss/regions/ufa_all.xml',
          nodes: {
              title: '.article_name',
              content: '.article_text_wrapper',
          }
      }
  }

  Post.delete_all

  sources.each do |source_name, source_attributes|
    rss_feed = Nokogiri::XML(open(source_attributes[:url]))
    rss_items = rss_feed.xpath('//channel//item')

    rss_items.each do |rss_item|
      article_link = rss_item.css('link').text
      article_image = rss_item.css('enclosure')[0]&.[]('url')
      article = Nokogiri::HTML(open(article_link))
      article_title = article.css(source_attributes[:nodes][:title]).text.strip
      article_content = article.css(source_attributes[:nodes][:content]).text.strip

      predictions = {
          traffic: [svm.traffic?(article_content), fann.traffic?(article_content)],
          sport: [svm.sport?(article_content), fann.sport?(article_content)],
          gov: [svm.gov?(article_content), fann.gov?(article_content)]
      }

      predictions.each do |category, values|
        if values[0] || values[1]
          rank = 0
          rank = 1 if values[0] && values[1]
          article_image = 'default.jpg' if article_image.nil?
          Post.create(
               title: article_title,
               content: article_content,
               link: article_link,
               author: source_name,
               category: category,
               rank: rank,
               image_source: article_image
           )
          puts "#{category} #{rank} #{article_title}"
        end
      end
    end
  end
 end
