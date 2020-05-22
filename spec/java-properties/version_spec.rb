require 'helper'

describe JavaProperties do
  it "should have a version" do
    _(JavaProperties::VERSION).wont_be_nil
  end
end
