['1_traffic', '2_sport', '3_gov'].each do |category|
  words = Hash.new(0)
  ['1_utv', '2_rg','3_kommersant'].each do |folder|
    Dir.glob("#{folder}/#{category}/*.txt").each do |text_file_path|
      File.open(text_file_path, 'r') do |text_file|
        content = text_file.read
        content.downcase!
        content.gsub!(/ё/,'е')
        content.gsub!(/[^А-я0-9]/,' ')
        content.gsub!(/\s{2,}/,' ')
        content.strip!
        content.split.each {|word| words[word] += 1}
      end
    end
  end
  puts "Категория: #{category}\n----"
  final_stats = words.sort_by {|key, value| - value }
  final_stats.each {|pair| puts "#{pair[0]}: #{pair[1]}"}
  puts "\n"
end



