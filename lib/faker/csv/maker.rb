
module Faker
  module Csv
    class Maker
      def initialize(json)
        @json = json
      end

      def make
        make_titles + make_content
      end

      private

      def make_titles
        @json.keys.join(', ') + "\n"
      end

      def make_content
        set_variables

        (0...@indexs[:count]).map do |count|
          make_row(count)
        end.join("\n") + "\n"
      end

      def make_row(count)
        row = []
        @json.each do |key, value|
          if value.kind_of?(Array)
            index = count / @indexs[key][:prev] % @indexs[key][:index]
            row << value[index]
          elsif value == 'index'
            row << count + 1
          elsif value =~ /Faker/
            row << eval(value)
          elsif value =~ /rb/
            ruby_sentence = value.sub(/^rb /, '')
            row << eval(ruby_sentence)
          else
            row << value
          end
        end
        row.join(', ')
      end

      def set_variables
        @indexs = {}
        index = 1
        @json.each do |key, value|
          next unless value.kind_of?(Array)
          @indexs[key] = {prev: index, index: value.count}
          index = index * value.count
        end

        @indexs[:count] = index
        true
      end
    end
  end
end