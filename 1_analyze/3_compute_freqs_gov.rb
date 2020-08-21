require 'yaml'

KEYWORDS = [
    /\bхабиров.*|\bради.*|\bназаров.*|\bглав.{1,2}\b|\bвице.*/,
    /\bчиновни.+|\bгуберн.+|\bпремьер.*|\bначальн.+|\bдепут.+|\bзаместител.+/,
    /\bправительств.*|\bадминистр.+|\bпрокур.*|\bминист.+/
]

def compute_freqs
  freqs = []
  ['1_traffic', '2_sport', '3_gov'].each do |category|
    ['1_utv', '2_rg','3_kommersant'].each do |folder|
      Dir.glob("#{folder}/#{category}/*.txt").each do |text_file_path|
        File.open(text_file_path, 'r') do |text_file|
          puts text_file_path
          matches = []
          content = text_file.read
          content.downcase!
          content.gsub!(/ё/,'е')
          content.gsub!(/[^А-я0-9]|\s{2,}/,' ')
          content.strip!
          KEYWORDS.each do |keyword|
            matches << content.scan(keyword).length
          end
          freqs << [matches, category == '3_gov' ? 1 : 0]
        end
      end
    end
  end
  File.open('train_data_gov.yml', 'w') { |file| file.write(freqs.to_yaml) }
end

compute_freqs
