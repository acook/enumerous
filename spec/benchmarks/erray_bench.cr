require "./bench_helper"
require "../../src/enumerous/erray"

a = Array(Int32).new
a << 1
a << 2
a << 3

p a, instance_sizeof(typeof(a))

e = Erray(Int32).new
e << 1
e << 2
e << 3

p e, instance_sizeof(typeof(e))

Benchmark.ips do |x|
  x.report("3e Array Concat") do
    a = Array(Int32).new
    a << 1
    a << 2
    a << 3
  end

  x.report("3e Erray Concat") do
    e = Erray(Int32).new
    e << 1
    e << 2
    e << 3
  end
end
