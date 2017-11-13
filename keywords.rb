require 'open-uri'
require 'nokogiri'
require 'watir'
require "google_drive"
require 'google/apis/drive_v2'

browser = Watir::Browser.new :chrome


session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1Wg62zgOoMvGwwNUHqHnzAx-NAJg-e7Aq9BZ7lnyDXCY").worksheets[0]
nbRows = ws.num_rows

while true do
begin
for siren in 3..nbRows

   website = ws[siren, 3]

browser.goto "#{website}"

if browser.meta(:name, 'keywords').exists?
  x = browser.meta(:name, 'keywords').html
  ws[siren, 5] = x
  ws.save
else
  puts "N/A"
  ws[siren, 5] = "N/A"
  ws.save
end
sleep(2)
end
rescue Exception => e
  raise
end
end
