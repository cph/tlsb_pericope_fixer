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
      
      def ensure_note_matches_note_id!(options={})
        book_name = options[:book]
        raise ArgumentError("You must say what book this is for") unless book_name
        
        document.css('note').each do |note|
          note_id = note.css('.note-id')[0]
          next unless note_id
          
          note_start, note_end = note_id["href"].split("-")
          note_end ||= note_start
          note["start"] = note_start
          note["end"] = note_end
        end
      end
      
    end
  end
end
