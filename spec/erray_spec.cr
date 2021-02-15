require "./spec_helper"
require "../src/enumerous/erray"

describe Enumerous do
  e1 = Erray{1,2}
  e2 = Erray{2,1}
  e3 = Erray{2,3}
  e4 = Erray{1,2,3}
  e5 = Erray{1,3}

  it "can check basic equality" do
    e1 == e2
  end

  describe "handy helpers" do
    describe "similarity" do
      it "knows when a same length erray contains different items" do
        (e1.similar e3).should be_false
      end

      it "knows when an array is missing an element" do
        (e4.similar e3).should be_false
      end

      it "knows when an array has an extra element" do
        (e1.similar e4).should be_false
      end

      it "knows when two errays contain the same elements" do
        (e1.similar e2).should be_true
      end

      it "works with native array types" do
        (e1.similar [2,1]).should be_true
      end
    end

    describe "diffing" do
      it "returns both extra and missing elements" do
        (e1.diff e3).map(){|e|e.to_a}.should eq({[3],[1]})
      end
    end

    describe "diffindexing" do
      it "returns the index of the first difference" do
        (e1.diff_index e5).should eq 1
      end

      it "returns the index equal to the length of the smaller list when longest is second" do
        (e1.diff_index e4).should eq 2
      end

      it "returns the index equal to the length of the smaller list when longest in first" do
        (e4.diff_index e1).should eq 2
      end

      it "returns nil if they have the same contents" do
        (e1.diff_index e1).should eq nil
      end
    end

    describe "finding and mapping" do
      it "returns nil when no value found" do
        (e1.find_and_map {|element| element > 2 && element.to_s }).should eq nil
      end

      it "returns a mapped value that it finds from an array" do
        (e1.find_and_map {|element| element > 1 && element.to_s }).should eq "2"
      end
    end
  end

end
