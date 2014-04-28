require 'selenium-webdriver'

username = 'SECRET'
pword = 'SECRET'


browser = Selenium::WebDriver.for :firefox
browser.get 'https://linkedin.com'
wait = Selenium::WebDriver::Wait.new(:timeout => 10)


input_username = wait.until do
  element = browser.find_element(:id, "session_key-login")
  element if element.displayed?
end
input_username.send_keys(username)

input_password = wait.until do
  element = browser.find_element(:id, "session_password-login")
  element if element.displayed?
end
input_password.send_keys(pword)
sleep 2

signin = wait.until do
  element = browser.find_element(:id, "signin")
  element if element.displayed?
end
signin.click
sleep 2

advanced_search = wait.until do
  element = browser.find_element(:id, "advanced-search")
  element if element.displayed?
end
advanced_search.click
sleep 2


# fill in search box
keywords = wait.until do
  element = browser.find_element(:id, "advs-keywords")
  element if element.displayed?
end
keywords.send_keys("ruby rails")

title = wait.until do
  element = browser.find_element(:id, "advs-title")
  element if element.displayed?
end
title.send_keys("engineering")

postal_code = wait.until do 
  element = browser.find_element(:id, "advs-postalCode")
  element if element.displayed?
end
postal_code.send_keys("94103")

distance = wait.until do
  element = browser.find_element(:id, "advs-distance")
  element if element.displayed?
end
distance.send_keys("10 ")

search = wait.until do
  element = browser.find_element(:class, "submit-advs")
  element if element.displayed?
end
search.click
sleep 2

# collect urls of all people on each page
profile_urls = []

profile_links = browser.find_elements(:css, "ol#results a.title")
profile_links.each { |link| profile_urls << link.attribute("href") }

# puts profile_urls
# do the same for the rest of the pages
pagination_urls = browser.find_elements(:css, ".pagination a")
      .map { |link| link.attribute("href") }
      
pagination_urls.each do |url|
  browser.get url
  sleep 1
  
  profile_links = wait.until do
    element = browser.find_elements(:css, "ol#results a.title")
    element if element.first.displayed?
  end
  profile_links.each { |link| profile_urls << link.attribute("href") }
end

puts profile_urls

profile_urls.each do |url|
  browser.get url
  sleep 2
end


