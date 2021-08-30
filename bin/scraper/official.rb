#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('strong').text.tidy.gsub(/[.,]$/,'').delete_prefix('- ')
    end

    def position
      noko.xpath('.//strong//following-sibling::text()').text.tidy.gsub(/[.,]$/,'').delete_prefix(': ')
    end

    private

    def tds
      noko.css('td')
    end
  end

  class Members
    def member_container
      noko.css('.article-details table').xpath('.//tr[td]')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
