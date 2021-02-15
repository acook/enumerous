module Enumerous::FindAndMap
  module FindAndMapEnumerable
    def find_and_map(fallback = nil)
      self.each do |*element|
        result = yield *element
        return result if result
      end
      fallback
    end
  end

  module FindAndMapNamedTuple
    include FindAndMapEnumerable
  end
end
