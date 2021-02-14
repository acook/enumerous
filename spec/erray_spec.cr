require "./spec_helper"
require "../src/enumerous/erray"

describe Enumerous do
  e1 = Erray{1,2}
  e2 = Erray{2,1}
  e3 = Erray{2,3}

  it "knows when a same length array contains different items" do
    (e1.similar e3).should be_false
  end

  it "knows when two arrays contain the same elements" do
    (e1.similar e2).should be_true
  end

  it "returns nil when no value found" do
    (e1.find_and_map {|element| element > 2 && element.to_s }).should eq nil
  end

  it "returns a mapped value that it finds from an array" do
    (e1.find_and_map {|element| element > 1 && element.to_s }).should eq "2"
  end
end
