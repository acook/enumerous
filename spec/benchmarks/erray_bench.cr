require "./bench_helper"
require "../../src/enumerous/erray"

Benchmark.ips do |x|
  x.report("Array creation") do
    a = Array(Int32).new
    a << 1
    a << 2
    a << 3
  end

  x.report("Erray creation") do
    a = Erray(Int32).new
    a << 1
    a << 2
    a << 3
  end
end
