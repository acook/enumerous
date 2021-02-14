class Enumerous::Erray(T) < Array(T)
  include Enumerous::Similar::SimilarArray
  include Enumerous::Diff::DiffArray
  include Enumerous::DiffIndex::DiffIndexArray
  include Enumerous::FindAndMap::FindAndMapEnumerable
end

{% unless flag?(:no_erray_alias) %}
  alias Erray = Enumerous::Erray
{% end %}
