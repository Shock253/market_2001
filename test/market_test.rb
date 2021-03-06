require "./test/test_helper"
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")

    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @vendor3.stock(@item1, 65)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_can_add_vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    vendors = [
      @vendor1,
      @vendor2,
      @vendor3
    ]

    assert_equal vendors, @market.vendors
  end

  def test_can_get_vendor_names
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    vendor_names = [
      "Rocky Mountain Fresh",
      "Ba-Nom-a-Nom",
      "Palisade Peach Shack"
    ]

    assert_equal vendor_names, @market.vendor_names
  end

  def test_can_get_vendors_that_sell_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    vendors1 = [
      @vendor1,
      @vendor3
    ]

    vendors2 = [
      @vendor2
    ]

    assert_equal vendors1, @market.vendors_that_sell(@item1)
    assert_equal vendors2, @market.vendors_that_sell(@item4)
  end

  def test_total_inventory
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    total_inventory = {
      @item1 => {
        quantity: 100,
        vendors: [@vendor1, @vendor3]
      },
      @item2 => {
        quantity: 7,
        vendors: [@vendor1]
      },
      @item4 => {
        quantity: 50,
        vendors: [@vendor2]
      },
      @item3 => {
        quantity: 35,
        vendors: [@vendor2, @vendor3]
      },
    }

    assert_equal total_inventory, @market.total_inventory
  end

  def test_overstocked_items
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@item1], @market.overstocked_items
  end

  def test_sorted_item_list
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)


    items = [
      "Banana Nice Cream",
      "Peach",
      "Peach-Raspberry Nice Cream",
      "Tomato"
    ]
    assert_equal items, @market.sorted_item_list
  end
end

# pry(main)> market.sorted_item_list
# #=> ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]
#
