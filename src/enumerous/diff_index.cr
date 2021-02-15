module Enumerous::DiffIndex
  module DiffIndexArray
    def diff_index(vs)
      limit = Math.min(size, vs.size)
      limit.times do |i|
        return i if self[i] != vs[i]
      end

      return limit unless self.size == vs.size
    end
  end
end
