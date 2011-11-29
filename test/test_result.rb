require 'helper'

class TestResult < Test::Unit::TestCase
  
  context "a result, when being parsed," do
    
    setup do
      VCR.use_cassette('bib_200') do
        @result = BostonMarathon.result(200)
      end
    end
    
    should "have the correct athlete_keys" do
      assert_equal ['Bib', 'Name', 'Age', 'M/F', 'City', 'St', 'Ctry', 'Ctz', ''], @result.send('athlete_keys')
    end
    
    should "have the correct athlete_vales" do
      assert_equal ['200', 'Iyer, Hari', '23', 'M', 'Cambridge', 'MA', 'USA', '', ''], @result.send('athlete_values')
    end
    
    should "have the correct split_keys" do
      assert_equal ['5k', '10k', '15k', '20k', 'Half', '25k', '30k', '35k', '40k'], @result.send('split_keys')
    end
    
    should "have the correct split_values" do
      assert_equal ['0:17:52', '0:35:35', '0:53:24', '1:11:15', '1:15:05', '1:28:44', '1:46:26', '2:03:49', '2:20:48'], @result.send('split_values')
    end
    
    should "have the correct finish_info_keys" do
      assert_equal ['Pace', 'Proj. Time', 'Offl. Time', 'Overall', 'Gender', 'Division'], @result.send('finish_info_keys')
    end
    
    should "have the correct finish_info_values" do
      assert_equal ['0:05:40', '', '2:28:39', '72', '61', '55'], @result.send('finish_info_values')
    end
    
    should "have the correct attrs hash" do
      assert_equal({"gender_place"=>"61", "state"=>"MA", "place"=>"72", "city"=>"Cambridge", "name"=>"Iyer, Hari", "division_place"=>"55", "country"=>"USA", "gender"=>"M", "bib"=>"200", "time"=>"2:28:39", "projected_time"=>"", "citizenship"=>"", "age"=>"23", "pace"=>"0:05:40", "splits" => {"5k"=>"0:17:52", "10k"=>"0:35:35", "15k"=>"0:53:24", "20k"=>"1:11:15", "half"=>"1:15:05", "25k"=>"1:28:44", "30k"=>"1:46:26", "35k"=>"2:03:49", "40k"=>"2:20:48"}}, @result.attrs)
    end
    
    should "correctly hashify two arrays" do
      assert_equal({"cat"=>"meow", "dog"=>"woof"}, @result.send(:hashify, ["dog", "cat"], ["woof", "meow"]))
    end
    
  end
  
end