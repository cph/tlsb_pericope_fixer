require 'tlsb/pericope_extensions'

module TLSB
  module Fixes
    module NoteIdFixes
      
      def ensure_note_id_existence!(options={})
        book_name = options[:book]
        raise ArgumentError("You must say what book this is for") unless book_name
        
        document.css('note').each do |note|
          next if note.css(".note-id").any?
          
          strong_tag = note.css('content > p > strong').first()
          unless strong_tag
            # puts "!"*80, note, "!"*80
            next
          end
          
          pericope = TLSB.parse_reference(strong_tag.text, options)
          id = TLSB.format_as_id(pericope)
          strong_tag << "<a class=\"note-id\" href=\"#{id}\">#{strong_tag.text}</a>"
        end
      end
      
      def ensure_note_id_accuracy!(options={})
        book_name = options[:book]
        raise ArgumentError("You must say what book this is for") unless book_name
        
        document.css('.note-id').each do |note_id|
          pericope = TLSB.parse_reference(note_id.text, book: book_name)
          note_id["href"] = TLSB.format_as_id(pericope)
        end
      end
      
    end
  end
end
