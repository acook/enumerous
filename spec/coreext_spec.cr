require "./spec_helper"
require "../src/enumerous/coreext"

describe Enumerous do
  describe Enumerous::Similar do
    it "knows when a same length array contains different items" do
      ([1,2].similar [2,3]).should be_false
    end

    it "knows when an array is missing an element" do
      ([1,2,3].similar [2,3]).should be_false
    end

    it "knows when an array has an extra element" do
      ([1,2].similar [1,2,3]).should be_false
    end

    it "knows when two arrays contain the same elements" do
      ([1,2].similar [2,1]).should be_true
    end
  end

  describe Enumerous::Diff do
    it "returns both extra and missing elements" do
      ([1,2].diff [2,3]).should eq({[3],[1]})
    end
  end

  describe Enumerous::DiffIndex do
    it "returns the index of the first difference" do
      ([1,2].diff_index [1,3]).should eq 1
    end
  end

  describe Enumerous::FindAndMap do
    it "returns nil when no value found" do
      ([1,2].find_and_map {|element| element > 2 && element.to_s }).should eq nil
    end

    it "returns a mapped value that it finds from an array" do
      ([1,2].find_and_map {|element| element > 1 && element.to_s }).should eq "2"
    end

    it "returns a mapped value that it finds from a hash" do
      ({:a => 1, :b => 2}.find_and_map {|key, value| value > 1 && "#{key}:#{value}" }).should eq "b:2"
    end

    it "returns a mapped value that it finds from a named tuple" do
      ({a: 1, b: 2}.find_and_map {|key, value| value > 1 && "#{key}:#{value}" }).should eq "b:2"
    end
  end
end
