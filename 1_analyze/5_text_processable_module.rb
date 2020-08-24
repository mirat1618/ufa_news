module TextProcessable
  require_relative 'keywords'

  def normalize_text_content(text_content)
    text_content.downcase.gsub(/ё/,'е').gsub(/[^А-я0-9]|\s{2,}/,' ').strip
  end

  def compute_matches(normalized_text_content, category)
    keywords_matches = []
    eval("#{category.upcase}_KEYWORDS").each do |keyword|
      keywords_matches << normalized_text_content.scan(keyword).size
    end
    keywords_matches
  end
end
