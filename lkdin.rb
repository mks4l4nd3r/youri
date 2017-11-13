#renseigner les identifiants linkedin ligne 25 et 26

require 'watir'
require 'selenium-webdriver'
require "google_drive"
require 'google/apis/drive_v2'


 profile = Selenium::WebDriver::Firefox::Profile.new
 profile['javascript.enabled'] = true

 browser = Watir::Browser.new :firefox, :profile => "default"


session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1Wg62zgOoMvGwwNUHqHnzAx-NAJg-e7Aq9BZ7lnyDXCY").worksheets[0]
nbRows = ws.nb_rows


browser.goto 'https://www.linkedin.com/'

sleep(1)

#remplacer par mail et mdp
browser.input(:name, 'session_key').send_keys('@gmail.com')
browser.input(:name, 'session_password').send_keys('#')
browser.send_keys(:enter)

sleep(2)

begin
for siren in 3..nbRows

   linkedin = ws[siren, 7]


browser.goto "#{linkedin}"

sleep(2)

if browser.element(:xpath, '//*[@id="org-about-company-module"]/div/div[2]/div[1]/p[5]').exists?
  puts browser.element(:xpath, '//*[@id="org-about-company-module"]/div/div[2]/div[1]/p[5]').html
  z = browser.element(:xpath, '//*[@id="org-about-company-module"]/div/div[2]/div[1]/p[5]').html
  ws[siren, 10] = z
  ws.save
  sleep(3)
else
  puts "N/A"
  ws[siren, 10] = "N/A"
  ws.save
  sleep(3)
end
sleep(2)
end
sleep(1)
rescue
puts ":()"
end
