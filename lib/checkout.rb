require 'basket'

class Checkout

  def initialize(promotional_rules = {}, basket = Basket.new)
    @basket = basket
    @item_promotion_rules = promotional_rules[:item_rules]
    @global_promotion_rules = promotional_rules[:global_rules]
  end

  def scan(item)
    basket.add(item)
  end

  def total
    subtotal = apply_item_promotion_to(basket)
    apply_global_promotion_to(subtotal).round(2)
  end

  private

  attr_reader :basket, :item_promotion_rules, :global_promotion_rules

  def apply_global_promotion_to(subtotal)
    return subtotal if global_promotion_rules.nil?
    subtotal - discount_for(subtotal, global_promotion_rules)
  end

  def apply_item_promotion_to (basket)
    return basket.total if item_promotion_rules.nil?
    basket.total - discount_for(basket, item_promotion_rules)
  end

  def discount_for(object, rules)
    discounts = rules.map { |rule| rule.call (object) }
    discounts.compact.reduce(0, :+)
  end
end
