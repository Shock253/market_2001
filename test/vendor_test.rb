require "./test/test_helper"
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    inventory = {}
    assert_equal inventory = {}, @vendor.inventory
  end

  def test_test_stocking
    assert_equal 0, @vendor.check_stock(@item1)

    @vendor.stock(@item1, 30)
    inventory = {@item1 => 30}

    assert_equal inventory, @vendor.inventory
    assert_equal 30, @vendor.check_stock(@item1)

    @vendor.stock(@item1, 25)
    inventory = {@item1 => 55}

    assert_equal 55, @vendor.check_stock(@item1)

    @vendor.stock(@item2, 12)
    inventory = {@item1 => 55, @item2 => 12}

    assert_equal inventory, @vendor.inventory
  end

  def test_can_check_for_item
    @vendor.stock(@item1, 30)
    assert_equal true, @vendor.has_item?(@item1)
    assert_equal false, @vendor.has_item?(@item2)
  end

  def test_can_estimate_potential_revenue
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)
    vendor1.stock(@item2, 7)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(@item4, 50)
    vendor2.stock(@item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(@item1, 65)

    assert_equal 29.75, vendor1.potential_revenue
    assert_equal 345.00, vendor2.potential_revenue
    assert_equal 48.75, vendor3.potential_revenue
  end
end


# pry(main)>vendor1.potential_revenue
# #=> 29.75
#
# pry(main)> vendor2.potential_revenue
# #=> 345.00
#
# pry(main)> vendor3.potential_revenue
# #=> 48.75
#
