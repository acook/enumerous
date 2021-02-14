module Enumerous::Diff
  module DiffArray
    def diff(vs)
      {(vs.to_a - self),(self - vs.to_a)}
    end
  end
end
