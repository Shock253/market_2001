require "./test/test_helper"
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
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
end
