module BostonMarathon
  
  class ResultSet < Array
  
    def initialize(response)
      noko = Nokogiri::HTML(response.body)
      results = []
      headers = noko.css('.tr_header')
      infogrids = noko.css('.table_infogrid')
      unless headers.empty? || infogrids.empty?
        headers.zip(infogrids).map { |arr| results << Result.new(arr[0], arr[1]) }
      end
      replace(results)
    end
    
  end

end