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

Benchmark.ips do |x|
  x.report("1000e Array Concat") do
    a = Array(Int32).new
    100.times do
    a << 1
    a << 2
    a << 3
    a << 4
    a << 5
    a << 6
    a << 7
    a << 8
    a << 9
    a << 10
    end
  end

  x.report("1000e Erray Concat") do
    e = Erray(Int32).new
    100.times do
    e << 1
    e << 2
    e << 3
    e << 4
    e << 5
    e << 6
    e << 7
    e << 8
    e << 9
    e << 10
    end
  end
end
