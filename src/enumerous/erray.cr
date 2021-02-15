class Enumerous::Erray(T)
  include Enumerable(T)
  include Indexable(T)
  include Comparable(Erray)

  include Enumerous::DiffIndex::DiffIndexArray
  include Enumerous::FindAndMap::FindAndMapEnumerable

  # implementation based on blacklight/redlight's sumo strings
  property len : UInt32 = 0_u32
  property cap : UInt32 = 0_u32
  property buffer : Pointer(T) = Pointer(T).null

  getter len
  getter cap

  # helpfully returns the object unchanged if it is already the correct type
  def self.wrap(erray : Erray(T)) : Erray(T)
    erray
  end

  # copies the contents of an array into a new erray
  def self.wrap(array : Array(T)) : Erray(T)
    alen = array.size.to_u
    ery = Erray(T).new(alen)
    ery.to_unsafe.copy_from(array.to_unsafe, array.size)
    ery.len = alen
    ery
  end

  # returns an empty erray if you pass in a nil
  # this matches the behaviour of ActiveSupport, but is this actually useful?
  def self.wrap(none : Nil) : Erray(T)
    new
  end

  # wraps any other object in an Erray
  def self.wrap(object) : Erray(T)
    Erray{object}
  end

  # creates an empty container with a given preallocation
  def initialize(@cap : UInt32)
    @buffer = Pointer(T).malloc(@cap)
  end

  # creates an empty container with no preallocation
  def initialize
  end

  def size
    @len.to_i
  end

  protected def len=(new_len : UInt32)
    @len = new_len
  end

  # returns the raw pointer to the internal buffer
  def to_unsafe
    @buffer
  end

  # required by Comparable
  # sort based on size rather than contents
  #
  # this differs from the base implementation
  # I'm curious about the use case for the original?
  #
  # It is tempting to make this use @cap instead,
  # so that they could be sorted based on actual memory usage
  def <=>(other)
    size <=> other.size
  end

  # required by Indexable
  # return a value based on its index in an efficient but unsafe way
  @[AlwaysInline]
  def unsafe_fetch(index : Int)
    @buffer[index]
  end

  # required by Crystal for Erray{a,b} syntax
  def <<(item : T) : self
    push item
    self
  end

  # same handy helpers available as coreext and modules
  def similar(to)
    (self - to).empty? && (to - self.to_a).empty?
  end

  def diff(vs)
    {(vs - self.to_a),(self - vs)}
  end

  def push(item : T)
    if avail > 0_u32
      @buffer[@len] = item
      @len += 1_u32
    else
      grow @cap + 1_u32
      push item
    end
  end

  def delete_at(index : UInt32) : T
    item = @buffer[index]
    (@buffer + index).copy_from(@buffer + index + 1_u32, @len - index)
    @len -= 1_u32
    item
  end

  def each
    @len.times do |i|
      yield @buffer[i]
    end
  end

  def -(other) : Erray(T)
    ery = Erray(T).new
    set = other.to_set

    each do |e|
      ery << e unless set.includes? e
    end

    ery
  end

  def +(other : Erray(U)) forall U
    new_len = @len + other.len
    ery = Erray(T | U).new(new_len)

    ery.to_unsafe.copy_from(@buffer, @len)
    (ery.to_unsafe + new_len - @len).copy_from(other.to_unsafe, other.len)
    ery.len = new_len
    ery
  end

  def to_a : Array(T)
    Array(T).build(@len) do |buf|
      buf.copy_from(@buffer, @len)
      @len
    end
  end

  # allocation stuff, will probably all end up private

  # memory used vs allocated
  @[AlwaysInline]
  def avail
    @cap - @len
  end

  # ensure buffer is at least this big
  def grow(new_cap : UInt32)
    if new_cap > @cap
      @buffer = @buffer.realloc(new_cap)
      @cap = new_cap
    end
  end

end

{% unless flag?(:no_erray_alias) %}
  alias Erray = Enumerous::Erray
{% end %}
