def normalize_text_content(text_content)
  text_content.downcase.gsub(/ё/,'е').gsub(/[^А-я0-9]|\s{2,}/,' ').strip
end

def compute_words_stats(*folders)
  words = Hash.new(0)
  folders.each do |folder|
    Dir.glob("#{folder}/*/*.txt").each do |text_file_path|
      File.open(text_file_path, 'r') do |text_file|
        content = normalize_text_content(text_file.read)
        content.split.each { |word| words[word] += 1 }
      end
    end
    final_stats = words.sort_by { |key, value| - value }
    puts "Категория: #{folder}\n----"
    final_stats.each { |pair| puts "#{pair[0]}: #{pair[1]}" }
    puts "\n"
  end
end

compute_words_stats('1_traffic', '2_sport', '3_gov')