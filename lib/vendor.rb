class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def has_item?(find_item)
    @inventory.any? do |item, _quantity|
      item == find_item
    end
  end

  def potential_revenue
    @inventory.reduce(0.0) do |revenue, item|
      revenue += item[0].price * item[1]
      revenue
    end
  end
end
