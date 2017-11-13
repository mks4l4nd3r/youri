require 'open-uri'
require 'nokogiri'
require 'watir'
require "google_drive"
require 'google/apis/drive_v2'

browser = Watir::Browser.new :chrome


session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1Wg62zgOoMvGwwNUHqHnzAx-NAJg-e7Aq9BZ7lnyDXCY").worksheets[0]
nbRows = ws.num_rows


for siren in 3..nbRows
  sir = ws[siren, 1]

browser.goto 'https://www.societe.com'

sleep(5)
# siren = "499425700"
browser.input(:type, 'text').send_keys("#{sir}")
browser.send_keys(:enter)
sleep(5)

if browser.element(:xpath,"//*[@id=\"etab2\"]/tbody/tr[6]/td[2]").exists?
  puts browser.element(:xpath,"//*[@id=\"etab2\"]/tbody/tr[6]/td[2]").text
  k = browser.element(:xpath,"//*[@id=\"etab2\"]/tbody/tr[6]/td[2]").text
  ws[siren, 4] = k
  ws.save
else
  puts "N/A"
  ws[siren, 4] = "N/A"
  ws.save
end

sleep(5)
end
