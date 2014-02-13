require 'helper'

describe JavaProperties::Generating::Generator do
  subject { JavaProperties::Generating::Generator }

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
      :item10 => "test\n\ttestה test\n\ttest test\n\ttest = test",
    }
  end

  it "generates properties file content" do
    expected = fixture("test_out.properties")
    content  = subject.generate(as_hash)
    content.must_equal expected
  end

end