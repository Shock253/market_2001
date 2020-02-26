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
end
