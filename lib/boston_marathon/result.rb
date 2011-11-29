module BostonMarathon
  
  class Result
    
    ATTR_TRANSLATE = {
      'm/f' => 'gender',
      'st' => 'state',
      'ctry' => 'country',
      'ctz' => 'citizenship',
      'proj. time' => 'projected_time',
      'offl. time' => 'time',
      'overall' => 'place',
      'gender' => 'gender_place',
      'division' => 'division_place'
    }
    
    attr_reader :attrs
    
    def initialize(header, infogrid)
      @header = header        # athlete bib, name, age, gender, city, state, country
      @infogrid = infogrid    # splits and finish info (pace, time, place, gender_place, division_place)
      set_attrs
    end
    
    def method_missing(method, *args)
      m = method.to_s.downcase
      if @attrs.has_key? m
        @attrs[m]
      else
        super
      end
    end
    
    private
    
    # ATHLETE
    
    def athlete_keys
      ['Bib', 'Name', 'Age', 'M/F', 'City', 'St', 'Ctry', 'Ctz', '']
    end
    
    def athlete_values
      cleanse(@header.css('td'))
    end
    
    # RESULT (which contains splits and finish info)
    
    def results_rows
      @results_rows ||= @infogrid.css('tr')
    end
    
    # SPLITS
    
    def split_keys
      cleanse(results_rows[0].css('th')[1..-1])
    end
    
    def split_values
      cleanse(results_rows[1].css('td'))
    end
    
    # FINISH INFO
    
    def finish_info_keys
      cleanse(results_rows[2].css('th')[1..-1])
    end
    
    def finish_info_values
      cleanse(results_rows[3].css('td'))
    end
    
    def set_attrs
      athlete = hashify(athlete_keys, athlete_values)
      splits = {'splits' => hashify(split_keys, split_values)}
      finish_info = hashify(finish_info_keys, finish_info_values)
      @attrs = athlete.merge(splits).merge(finish_info)
    end
    
    # hashify does not belong on the result model. Move it later.
    # usage: hashify(["dog", "cat"], ["woof", "meow"]) # => {"cat"=>"meow", "dog"=>"woof"}
    def hashify(keys, values)
      keys = keys.map(&:downcase).map{ |k| ATTR_TRANSLATE.has_key?(k) ? ATTR_TRANSLATE[k] : k }
      arr_of_arrs = keys.zip(values).delete_if { |arr| arr[0] == "" }
      Hash[arr_of_arrs]
    end
    
    # cleanse does not belong on the result model. Move it later.
    # remove whitespaces and instances of &nbsp;
    def cleanse(arr)
      arr.map{|cell| cell.inner_text.gsub(/\302\240/, ' ').strip}
    end
    
  end
  
end