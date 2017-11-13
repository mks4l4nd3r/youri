require 'watir'
require 'selenium-webdriver'
require "google_drive"
require 'google/apis/drive_v2'

b = Watir::Browser.new(:chrome)

#il faut rescale pour que ça fonctionne avec beaucoup de données
#et faire tourner son ip ainsi que le script avec des pauses variables
#pour que google ne détecte pas le bot

def watir_powned(b)

  # spreadsheets init
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1Wg62zgOoMvGwwNUHqHnzAx-NAJg-e7Aq9BZ7lnyDXCY").worksheets[0]
  nbRows = ws.num_rows

# debut loop spreadsheets
for url in 3..nbRows
  u = ws[url, 2]
  u = u.downcase
  puts u
  # debut du recuperateur

  # watir init
  b.goto("google.fr")
  boite = "hopwork"

  facebook page recuperation
  b.element(:class, "gsfi").send_keys("#{u} inurl:facebook.com")
  b.send_keys(:enter)
  facebook_page = b.element(:class, "_Rm").text
  puts facebook_page

  ws[url, 6] = facebook_page
  ws.save
  sleep(1)

  # crunchbase page recuperation
  b.goto("google.fr")
  b.element(:class, "gsfi").send_keys("#{u} inurl:crunchbase.com")
  b.send_keys(:enter)
  crunchbase_page = b.element(:class, "_Rm").text
  puts crunchbase_page

  ws[url, 5] = crunchbase_page
  ws.save
  sleep(1)

  #linkedin page recuperation
  b.goto("google.fr")
  b.element(:class, "gsfi").send_keys("#{u} inurl:linkedin.com")
  b.send_keys(:enter)
  linkedin_page = b.element(:class, "_Rm").text
  puts linkedin_page

  ws[url, 7] = linkedin_page
  ws.save
  sleep(1)


  #website page recuperation
  b.goto("google.fr")
  b.element(:class, "gsfi").send_keys("#{u}")
  b.send_keys(:enter)
  website_page = b.element(:class, "_Rm").text
  puts website_page

  ws[url, 3] = website_page
  ws.save
  sleep(1)

  # fin du recuperateur

  # fin de la loop spreadsheets
  end
end

watir_powned(b)
