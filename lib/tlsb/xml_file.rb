require 'nokogiri'
require 'tlsb/fixes/note_id_fixes'

module TLSB
  class XmlFile
    include Fixes::NoteIdFixes
    
    
    def initialize(file_path)
      @file_path = file_path
    end
    
    attr_reader :file_path
    
    def document
      @document ||= read_file!
    end
    
    
  private
    
    
    def read_file!
      xml = File.read(file_path)
      Nokogiri::HTML(xml)
    end
    
    
  end
end
