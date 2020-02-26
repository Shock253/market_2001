class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.reduce([]) do |names, vendor|
      names << vendor.name
      names
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.has_item?(item)
    end
  end

  def total_inventory
    @vendors.reduce(Hash.new) do |inventory, vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item] ||= {quantity: 0, vendors:[]}
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
      inventory
    end
  end

  def overstocked_items
    total_inventory.reduce([]) do |items, item_info|
      if item_info[1][:vendors].length > 1 && item_info[1][:quantity] > 50
        items << item_info[0]
      end
      items
    end
  end

  def sorted_item_list
    total_inventory.keys.map do |item|
      item.name
    end.sort
  end
end
