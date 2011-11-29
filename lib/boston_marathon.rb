$:.unshift(File.dirname(__FILE__))

require 'rest_client'
require 'nokogiri'

require 'boston_marathon/record_not_found'
require 'boston_marathon/result_set'
require 'boston_marathon/result'

module BostonMarathon
  
  BASE_URL = "http://registration.baa.org/2011/cf/Public/iframe_ResultsSearch.cfm?mode=results"
  RESULTS_PER_PAGE = 25 # up to 25 results can be retrieved at a time
  RACE_CAP = 30000      # an arbitrary number that's larger than the number of race participants
  
  class << self
  
    # returns the result for a specific bib number
    def result(bib)
      result_set = fetch({'BibNumber' => bib})
      raise BostonMarathon::RecordNotFound if result_set.empty?
      result_set[0]
    end
    
    # returns a max of RESULTS_PER_PAGE results.
    # see README for list of query params
    def results(params)
      fetch({'VarTargetCount' => RACE_CAP}.merge params)
    end
    
    private
    
    def fetch(params={})
      response = RestClient.post BASE_URL, params
      BostonMarathon::ResultSet.new(response)
    end
  
  end
  
end
