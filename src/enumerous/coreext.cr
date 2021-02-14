require "./all"

module Enumerous::CoreExt
end

class Array
  include Enumerous::Similar::SimilarArray
  include Enumerous::Diff::DiffArray
  include Enumerous::DiffIndex::DiffIndexArray
end

module Enumerable
  include Enumerous::FindAndMap::FindAndMapEnumerable
end

struct NamedTuple
  include Enumerous::FindAndMap::FindAndMapNamedTuple
end
