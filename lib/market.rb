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
end
