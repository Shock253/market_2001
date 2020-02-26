require "./test/test_helper"
require './lib/item'
require './lib/vendor'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_has_attributes
    assert_equal "Tomato", @item.name
    assert_equal 0.50, @item.price
  end
end


# pry(main)> item1 = Item.new({name: 'Peach', price: "$0.75"})
# #=> #<Item:0x007f9c56740d48...>
#
# pry(main)> item = Item.new({name: 'Tomato', price: '$0.50'})
# #=> #<Item:0x007f9c565c0ce8...>
#
# pry(main)> item.name
# #=> "Tomato"
#
# pry(main)> item.price
# #=> 0.50
#
