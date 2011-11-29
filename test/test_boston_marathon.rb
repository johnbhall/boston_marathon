require 'test/helper'

class TestBostonMarathon < Test::Unit::TestCase
  
  context "when looking up a result by an INVALID bib number" do
    
    should "raise a RecordNotFound exception" do
      assert_raise BostonMarathon::RecordNotFound do
        VCR.use_cassette('bad_bib') do
          @result = BostonMarathon.result('a')
        end
      end
    end
    
  end
  
  context "when looking up a result by a VALID bib number" do
    
    setup do
      VCR.use_cassette('bib_43') do
        @result = BostonMarathon.result(43)
      end
    end
    
    should "have the correct athlete attributes" do
      expected = ['43', 'Krah, Nathan M.', '25', 'M', 'Boston', 'MA', 'USA']
      tested = [@result.bib, @result.name, @result.age, @result.gender, @result.city, @result.state, @result.country]
      assert_equal expected, tested
    end
    
    should "have the correct splits" do
      expected = {
        '5k'  => '0:16:40',
        '10k' => '0:33:24',
        '15k' => '0:50:03',
        '20k' => '1:06:46',
        'half' => '1:10:25',
        '25k' => '1:23:42',
        '30k' => '1:40:39',
        '35k' => '1:57:52',
        '40k' => '2:14:53'
      }
      assert_equal expected, @result.splits
    end
    
    should "have the correct finish info" do
      expected = ['0:05:26', '', '2:22:24', '29', '29', '25']
      tested = [@result.pace, @result.projected_time, @result.time, @result.place, @result.gender_place, @result.division_place]
      assert_equal expected, tested
    end
    
  end
  
  context "when searching for" do
    
    context "the top 20 women" do
      
      setup do
        VCR.use_cassette('top_20_women') do
          @results = BostonMarathon.results({'GenderID' => 2, 'VarTargetCount' => 20})
        end
      end
      
      should "return the results of the 20 fastest female runners" do
        assert_equal 20, @results.length
        assert_equal ["F"], @results.map(&:gender).uniq
      end
      
    end
    
    context "someone matching very specific attributes" do
      
      setup do
        VCR.use_cassette('ryan_hall') do
          @results = BostonMarathon.results({
            'BibNumber' => 3,
            'LastName' => 'Hall',
            'FirstName' => 'Ryan',
            'ReportingSegmentId' => 1,
            'GenderID' => 1,
            'City' => 'Mammoth Lakes',
            'StateID' => '10',
            'CountryOfResID' => 193
          })
        end
      end
      
      should "return the athlete we're looking for" do
        assert_equal 1, @results.length
        assert_equal "Hall, Ryan", @results[0].name
      end
      
    end
    
  end
  
end