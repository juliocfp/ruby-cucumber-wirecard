require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec'
require 'httparty'
require 'capybara'

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 4

Capybara.register_driver :selenium do |app|
	options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--window-size=1280,820")
	Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Selenium::WebDriver::Chrome.driver_path = 'C:\code\wirecard\test-automation\chromedriver.exe'
