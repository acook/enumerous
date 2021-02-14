module Enumerous::DiffIndex
  module DiffIndexArray
    def diff_index(vs)
      index = 0
      self.each do |element|
        return index if element != vs[index]
        index += 1
      end
    end
  end
end
