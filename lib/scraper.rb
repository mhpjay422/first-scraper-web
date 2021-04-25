require 'HTTParty'
require 'Nokogiri'
require 'pry'

class Scraper 

attr_accessor :parse_page, :item_container, :names

  def initialize
    doc = HTTParty.get("https://www.nike.com/w/mens-shoes-nik1zy7ok")
    @parse_page ||= Nokogiri::HTML(doc) 
    @item_container = @parse_page.css(".product-grid__items")
  end
  
  
  def product_names 
    @item_container.css(".product-card__link-overlay").map {|product| product.text}.compact
  end

  def product_prices 
    @item_container.css(".product-price").map {|product| product.text}.compact
  end  

  private 
  scraper = Scraper.new 
  names = scraper.product_names
  prices = scraper.product_prices

  (0...names.size).each do |index|
    puts "- - - index: #{index + 1} - - -" 
    puts "Name: #{names[index]} | price: #{prices[index]}"
  end
  
end