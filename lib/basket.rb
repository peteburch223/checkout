class Basket

  include Enumerable

  def initialize
    @all =[]
  end

  def each(&block)
    all.each(&block)
  end

  def add(item)
    all << item
  end

  def total
    all.reduce(0) { |total, item| total += item.price }
  end

  private

  attr_reader :all
end
