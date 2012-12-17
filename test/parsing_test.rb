require "test_helper"


class ParsingTest < ActiveSupport::TestCase
  
  
  test "it should be able to parse some sample HTML and find all the tags that match a.bible" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Leviticus-studynotes.xml")
    
    links = file.document.css("a.bible")
    assert_equal 386, links.length
  end
  
  
  test "it should ensure that every note has a .note-id that links back to its original context" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Genesis-studynotes.xml")
    assert_equal 35, file.document.css("note").count { |note| note.css(".note-id").empty? }
    file.ensure_note_id_existence!(book: "Genesis")
    
    # note: there's still 1 bad note because it doesn't have a reference part at all
    assert_equal 1, file.document.css("note").count { |note| note.css(".note-id").empty? }
  end
  
  
end
