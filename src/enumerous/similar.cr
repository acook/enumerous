module Enumerous::Similar
  module SimilarArray
    def similar(to)
      (self - to.to_a).empty? && (to.to_a - self.to_a).empty?
    end
  end
end
