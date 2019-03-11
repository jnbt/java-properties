require 'helper'

describe JavaProperties::Parsing::Parser do
  subject { JavaProperties::Parsing::Parser }

  let(:as_hash) do
    {
      :item0 => "",
      :item1 => "item1",
      :item2 => "item2",
      :item3 => "item3",
      :"it em4" => "item4",
      :"it=em5" => "item5",
      :item6 => "item6",
      :item7 => "line 1 line 2 line 3",
      :item8 => "line 1 line 2 line 3",
      :item9 => "line 1 line 2 line 3",
      :item10 => "test\n\ttestP test\n\ttest test\n\ttest = test",
      :item11 => "aäb 𪀯",
      :item12 => "#no comment",
    }
  end

  it "parses correctly a properties file content" do
    content    = fixture("test.properties")
    properties = subject.parse(content)

    # don't compare the hashes directly, as this hard to debug
    properties.keys.must_equal as_hash.keys
    properties.each do |key, value|
      value.must_equal as_hash[key]
    end
  end

end
