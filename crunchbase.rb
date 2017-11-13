require 'open-uri'
require 'nokogiri'
require 'watir'
require "google_drive"
require 'google/apis/drive_v2'

browser = Watir::Browser.new :chrome

#il faut refactoriser le code pour le faire tourner de façon aléatoire, avec plusieurs
#navigateurs, crunchbase a un systeme antibot solide

while true do
begin
website = "https://www.crunchbase.com/organizations/hopwork"
sleep(10)
browser.goto "#{website}"

x = browser.div(:class, 'component--fields-card').html
puts x

sleep(2)
#end
rescue Exception => e
  raise
end
end
