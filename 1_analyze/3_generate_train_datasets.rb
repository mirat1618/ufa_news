require 'yaml'
require_relative 'keywords'

def normalize_text_content(text_content)
  text_content.downcase!
  text_content.gsub!(/ё/,'е')
  text_content.gsub!(/[^А-я0-9]|\s{2,}/,' ')
  text_content.strip!
end

@@category_values = {'1_traffic' => [TRAFFIC_KEYWORDS, 'traffic'],
              '2_sport' => [SPORT_KEYWORDS, 'sport'],
              '3_gov' => [GOV_KEYWORDS, 'gov'],
}

def compute_freqs
  freqs = []
  ['1_traffic', '2_sport', '3_gov'].each do |category|
    ['1_utv', '2_rg','3_kommersant'].each do |folder|
      Dir.glob("#{folder}/#{category}/*.txt").each do |text_file_path|
        File.open(text_file_path, 'r') do |text_file|
          puts text_file_path
          matches = []
          content = normalize_text_content(text_file.read)
          @@category_values[category].each do |keyword|
            matches << content.scan(keyword).length
          end
          freqs << [matches, category[0].to_i]
        end
      end
    end
  end
  File.open("4_data_sets/#{}", 'w') { |file| file.write(freqs.to_yaml) }
end

compute_freqs

