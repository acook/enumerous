module Enumerous::FindAndMap
  module FindAndMapEnumerable
    def find_and_map
      self.each do |*element|
        result = yield *element
        return result if result
      end
    end
  end

  module FindAndMapNamedTuple
    include FindAndMapEnumerable
  end
end
