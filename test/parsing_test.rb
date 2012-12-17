require "test_helper"


class ParsingTest < ActiveSupport::TestCase
  
  
  test "it should be able to parse some sample HTML and find all the tags that match a.bible" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Leviticus-studynotes.xml")
    
    links = file.document.css("a.bible")
    assert_equal 386, links.length
  end
  
  
end
