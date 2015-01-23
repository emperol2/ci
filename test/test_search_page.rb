require 'test/unit'
require 'rubygems'
require 'selenium-webdriver'


module Test
  class TestSearchPage < Test::Unit::TestCase

    # Called before every test method runs. Can be used
    # to set up fixture information.
    def setup
      @driver = Selenium::WebDriver.for :phantomjs
      @driver.navigate.to('http://www.bk.com/search')
      @driver.manage.timeouts.implicit_wait = 20
      @wait = Selenium::WebDriver::Wait.new :timeout => 20
    end

    # Called after every test method runs. Can be used to tear
    # down fixture information.

    def test_search_found
      @driver.find_element(:css, '#edit-term').send_keys('burger')
      @driver.find_element(:css, '#views-exposed-form-search-page button').click
      assert @driver.title.include?('search')
      resultList = @driver.find_elements(:css, '.itemsList li')
      resultList.each do |r|
        htmlResults = r.attribute('innerHTML')
        assert (htmlResults.match /burger/i)
      end
    end

    def element_present?(how, what)
      found = @driver.find_element(how => what)
      if found
        true # return true if this element is found
      else
        false # return false if this element is not found
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError # catch if NoSuchElementError appears
      false
    end

    def teardown
      # Do nothing
      @driver.quit
    end

  end
end