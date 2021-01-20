require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_instance_and_attributes
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    assert_instance_of Item, item2
    assert_equal "Tomato", item2.name
    assert_equal "$0.50", item2.price
  end
end
