class GaussParser
  require 'nokogiri'
  require 'open-uri'
  SITE = 'http://gauss.ru'

  attr_reader :articuls
  attr_reader :parsing_results
  attr_reader :links
  attr_reader :keys

  def initialize(articuls)
    @articuls = articuls
    @parsing_results = []
    @links = {}
    @keys = ["link"]
  end

  def search_links
    articuls.each do |a|
      link_for_search = "#{SITE}/?s=#{a}"
      puts a
      search_page = Nokogiri::HTML(open(link_for_search))
      begin
        product_link = search_page.css("a[class='gblue']")[0]['href']
        product_page = Nokogiri::HTML(open(product_link))
      rescue StandardError => e
        puts "#{a} has no page"
      else
          result = {}
          properties = {}
          result["link"] = product_link
          properties_values = product_page.css('div[class="col-xs-12"]').select { |value| value.to_s.include? 'product' }
          properties_values.each do |p|
            property_name = p.to_s.scan(/([>])([[:print:]]+)([:])([[:print:]]+)([>])([[:print:]]+)([<])/)[0][1].strip
            property_value = p.to_s.scan(/([>])([[:print:]]+)([:])([[:print:]]+)([>])([[:print:]]+)([<])/)[0][5].strip
            keys << property_name
            result[property_name] = property_value
          end
        end
      #end
      @parsing_results << result
    end
    keys.uniq!
  end
end
