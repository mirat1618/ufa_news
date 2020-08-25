require 'scrapers/scraper'

task scrape: :environment do
  begin
    scrape
  rescue => error
    puts error
  end
end

