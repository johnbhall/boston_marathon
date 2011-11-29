Boston Marathon
===============

A Ruby wrapper for race results from the [2011 Boston Marathon](http://www.baa.org/races/boston-marathon/results-commentary/results-search.aspx).
Result data is retrieved by parsing HTML documents with [Nokogiri](http://nokogiri.org/),
so this version of the gem will work as long as the format of the site doesn't change.

Install / Getting Started
-------------------------

    gem install boston_marathon

Usage
-----

### Look up an athlete's result by their bib number

    result = BostonMarathon.result(43)
    result.name      # => 'Krah, Nathan M.'
    result.time      # => '2:22:24'
    result.pace      # => '0:05:26'
    result.place     # => '29'

Like ActiveRecord, a RecordNotFound exception is raised when looking up a bib that has no result.

### Search the results

This method will return a maximum of 25 entries, a limit imposed by the Boston Marathon website.
To specify a smaller limit, use the VarTargetCount param.

    top_20_women = BostonMarathon.results({'GenderID' => 2, 'VarTargetCount' => 20})
    top_20_women.each do |result|
      puts "#{result.gender_place.rjust(2)}. #{result.name}"
    end
    
Query Params for #results
-------------------------

- BibNumber
- LastName
- FirstName
- GenderID
- City
- StateID
- CountryOfResID
- ReportingSegmentID
- QualClassID
- AwardsDivisionID
- VarTargetCount

### IDs for genders

    {"1" => "M", "2" => "F"}

### IDs for reporting segments

    {"1" => "Runners", "2" => "Wheelchairs", "3" => "Handcycles"}

### IDs for qualification classes

    {"8" => "Handcycle", "2" => "Mobility Impaired", "4" => "Push Rim Wheelchair Class 1 (Quad)", "5" => "Push Rim Wheelchair Class 2 (Quad)", "6" => "Push Rim Wheelchair Class 3 (Open)", "7" => "Push Rim Wheelchair Class 4 (Open)", "1" => "Visually Impaired (B1, B2, B3)"}

### IDs for awards divisions

    {"1" => "18-39 Age Group", "2" => "40-44 Age Group", "9" => "45-49 Age Group", "3" => "50-54 Age Group", "10" => "55-59 Age Group", "4" => "60-64 Age Group", "11" => "65-69 Age Group", "8" => "70-74 Age Group", "12" => "75-79 Age Group", "13" => "80+ Age Group"}

### IDs for states

    {"5" => "Alabama", "4" => "Alaska", "64" => "Alberta", "8" => "American Samoa", "9" => "Arizona", "7" => "Arkansas", "2" => "Armed Forces Americas", "3" => "Armed Forces Europe", "6" => "Armed Forces Pacific", "65" => "British Columbia", "10" => "California", "11" => "Colorado", "12" => "Connecticut", "14" => "Delaware", "13" => "District Of Columbia", "16" => "Federated States of Micronesia", "15" => "Florida", "17" => "Georgia", "18" => "Guam", "19" => "Hawaii", "21" => "Idaho", "22" => "Illinois", "23" => "Indiana", "20" => "Iowa", "24" => "Kansas", "25" => "Kentucky", "26" => "Louisiana", "29" => "Maine", "67" => "Manitoba", "30" => "Marshall Island", "28" => "Maryland", "27" => "Massachusetts", "31" => "Michigan", "32" => "Minnesota", "35" => "Mississippi", "33" => "Missouri", "36" => "Montana", "39" => "Nebraska", "43" => "Nevada", "68" => "New Brunswick", "40" => "New Hampshire", "41" => "New Jersey", "42" => "New Mexico", "44" => "New York", "66" => "Newfoundland and Labrador", "37" => "North Carolina", "38" => "North Dakota", "34" => "Northern Mariana Islands", "71" => "Northwest Territories", "70" => "Nova Scotia", "77" => "Nunavut", "45" => "Ohio", "46" => "Oklahoma", "72" => "Ontario", "47" => "Oregon", "50" => "Palau", "48" => "Pennsylvania", "73" => "Prince Edward Island", "49" => "Puerto Rico", "74" => "Quebec", "51" => "Rhode Island", "75" => "Saskatchewan", "52" => "South Carolina", "53" => "South Dakota", "54" => "Tennessee", "55" => "Texas", "56" => "Utah", "59" => "Vermont", "58" => "Virgin Islands", "57" => "Virginia", "60" => "Washington", "62" => "West Virginia", "61" => "Wisconsin", "63" => "Wyoming", "76" => "Yukon"}

### IDs for countries

    {"196"=>"Venezuela", "168"=>"Saint Lucia", "54"=>"Djibouti", "25"=>"Belize", "82"=>"Hong Kong", "197"=>"Vietnam", "169"=>"Sao Tome and Principe", "26"=>"Burkina Faso", "110"=>"Luxembourg", "83"=>"Honduras", "55"=>"Dominica", "27"=>"Belarus", "84"=>"Hungary", "140"=>"Oman", "56"=>"Dominican Republic", "28"=>"Bolivia", "112"=>"Madagascar", "85"=>"Indonesia", "141"=>"Pakistan", "113"=>"Morocco", "29"=>"Botswana", "86"=>"India", "57"=>"Ecuador", "170"=>"Saint Vincent and the Grenadines", "142"=>"Palestine", "114"=>"Malaysia", "87"=>"Ireland", "58"=>"Egypt", "171"=>"Sudan", "143"=>"Panama", "115"=>"Malawi", "59"=>"El Salvador", "172"=>"Switzerland", "144"=>"Paraguay", "116"=>"Mexico", "30"=>"Brazil", "88"=>"Islamic Republic of Iran", "200"=>"Yugoslavia", "173"=>"Suriname", "145"=>"Peru", "117"=>"Mongolia", "31"=>"Brunei Darussalam", "89"=>"Iraq", "60"=>"Spain", "174"=>"Slovakia", "146"=>"Philippines", "118"=>"Maldives", "32"=>"Bulgaria", "201"=>"Congo, The Democratic Republic of the", "202"=>"Zambia", "175"=>"Sweden", "147"=>"Poland", "119"=>"Mali", "61"=>"Estonia", "203"=>"Zimbabwe", "176"=>"Swaziland", "148"=>"Portugal", "90"=>"Iceland", "62"=>"Ethiopia", "177"=>"Syrian Arab Republic", "34"=>"British Virgin Islands", "91"=>"Israel", "149"=>"Korea, Democratic People's Republic of", "63"=>"Fiji", "204"=>"Burundi", "178"=>"Tanzania, United Republic of", "35"=>"Central African Republic", "64"=>"Finland", "205"=>"Bosnia and Herzegovina", "179"=>"Thailand", "120"=>"Malta", "2"=>"Afghanistan", "93"=>"Italy", "65"=>"France", "206"=>"Eritrea", "36"=>"Canada", "3"=>"Netherlands Antilles", "94"=>"Jamaica", "37"=>"Cayman Islands", "150"=>"Yemen", "122"=>"Moldova, Republic of", "4"=>"Albania", "95"=>"Jordan", "66"=>"Gabon", "208"=>"Lao People's Democratic Republic", "38"=>"Congo", "209"=>"Slovenia", "151"=>"Qatar", "123"=>"Monaco", "5"=>"Algeria", "96"=>"Japan", "67"=>"Gambia", "39"=>"Chad", "68"=>"United Kingdom", "180"=>"Tajikistan", "124"=>"Mozambique", "97"=>"Kenya", "10"=>"Antigua and Barbuda", "181"=>"Turkmenistan", "153"=>"Romania", "125"=>"Mauritius", "7"=>"Andorra", "98"=>"Kyrgyzstan", "69"=>"Guinea-Bissau", "154"=>"South Africa", "11"=>"Argentina", "40"=>"Chile", "8"=>"Angola", "183"=>"Togo", "155"=>"Russian Federation", "12"=>"Armenia", "210"=>"Macedonia, The Former Yugoslav Republic of", "127"=>"Mauritania", "41"=>"China", "99"=>"Cambodia", "184"=>"Tonga", "211"=>"Taiwan", "156"=>"Rwanda", "128"=>"Myanmar", "13"=>"Aruba", "70"=>"Georgia", "42"=>"Cote d'Ivoire (Ivory Coast)", "212"=>"Serbia and Montenegro", "157"=>"Samoa", "129"=>"Namibia", "14"=>"Australia", "71"=>"Equatorial Guinea", "43"=>"Cook Islands", "186"=>"Trinidad and Tobago", "158"=>"Saudi Arabia", "72"=>"Germany", "15"=>"Austria", "187"=>"Tunisia", "159"=>"Senegal", "100"=>"Korea, Republic of", "73"=>"Ghana", "44"=>"Cameroon", "16"=>"Azerbaijan", "188"=>"Turkey", "101"=>"Kuwait", "45"=>"Colombia", "17"=>"Bahamas", "189"=>"United Arab Emirates", "130"=>"Nauru", "75"=>"Greece", "46"=>"Comoros", "18"=>"Bangladesh", "102"=>"Kazakhstan", "131"=>"Nicaragua", "76"=>"Grenada", "47"=>"Costa Rica", "19"=>"Barbados", "103"=>"Latvia", "160"=>"Seychelles", "132"=>"Netherlands", "48"=>"Croatia", "104"=>"Libyan Arab Jamahiriya", "161"=>"Singapore", "133"=>"Nepal", "77"=>"Guatemala", "49"=>"Cuba", "105"=>"Liberia", "190"=>"Uganda", "162"=>"Sierra Leone", "134"=>"Nigeria", "106"=>"Lesotho", "20"=>"Belgium", "78"=>"Guinea", "191"=>"Ukraine", "163"=>"San Marino", "135"=>"Papua New Guinea", "107"=>"Lebanon", "21"=>"Benin", "192"=>"Uruguay", "164"=>"Solomon Islands", "136"=>"Niger", "50"=>"Cape Verde", "108"=>"Liechtenstein", "193"=>"United States of America", "165"=>"Somalia", "51"=>"Cyprus", "109"=>"Lithuania", "22"=>"Bermuda", "194"=>"Uzbekistan", "166"=>"Sri Lanka", "138"=>"Norway", "52"=>"Czech Republic", "23"=>"Bahrain", "80"=>"Guyana", "195"=>"Vanatu", "167"=>"Saint Kitts and Nevis", "139"=>"New Zealand", "53"=>"Denmark", "24"=>"Bhutan", "81"=>"Haiti"}

License
-------

(The MIT License)

Copyright (c) 2011 John B. Hall

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.