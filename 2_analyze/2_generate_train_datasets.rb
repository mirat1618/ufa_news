require 'yaml'
require_relative 'keywords'

def normalize_text_content(text_content)
  text_content.downcase!
  text_content.gsub!(/ё/,'е')
  text_content.gsub!(/[^А-я0-9]|\s{2,}/,' ')
  text_content.strip!
end

def generate_train_datasets(keywords, *folders, output_folder)
  categories = folders.map {|folder| folder.match(/\d+_(.*)/)[1] }
  categories.each.with_index do |category, index|
    freqs = []
    folders.each do |folder|
      Dir.glob("#{folder}/*/*.txt").each do |text_file_path|
        puts text_file_path
        File.open(text_file_path, 'r') do |text_file|
          keywords_matches = []
          content = normalize_text_content(text_file.read)
          keywords[index].each do |keyword|
            keywords_matches << content.scan(keyword).length
          end
          freqs << [keywords_matches, folder.include?(category) ? 1 : 0]
        end
      end
    end
    File.open("#{output_folder}/#{index+1}_#{category}_dataset.yaml", 'w') {|file| file.write(freqs.to_yaml)}
  end
end

keywords = [TRAFFIC_KEYWORDS, SPORT_KEYWORDS, GOV_KEYWORDS]
generate_train_datasets(keywords, '1_traffic', '2_sport', '3_gov', '4_datasets')

