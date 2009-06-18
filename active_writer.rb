require 'csv'

class CSV
  class Writer
    class ActiveRecord
      attr_accessor :name, :header
      
      def initialize(name="csv", attributes=[], header=false)
        @name, @attributes, @header = name, attributes, header
      end
      
      def write(collection)
        stream = StringIO.new
        
        CSV::Writer.generate(stream, ', ') do |title|
          title << @attributes if @header
          collection.each { |item| title << @attributes.map { |a| item.try("#{a}") } }
        end
        
        stream.rewind
        stream.read
      end
      
      def headers
        {
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :filename => "#{self.name}-#{Date.today.to_s.gsub(" ", "-")}.csv",
          :disposition => 'attachment',
          :encoding => 'utf8'
        }
      end
    end
  end
end