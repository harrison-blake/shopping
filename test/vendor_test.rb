require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_instance_and_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")
    starting_hash = {}

    assert_instance_of Vendor, vendor
    assert_equal "Rocky Mountain Fresh", vendor.name
    assert_equal starting_hash, vendor.inventory
  end

  def test_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    vendor.stock(item1, 30)

    answer_hash = {item1 => 30}

    assert_equal answer_hash, vendor.inventory
  end

  def test_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor.stock(item1, 30)
    vendor.stock(item1, 25)
    vendor.stock(item2, 12)

    assert_equal 55, vendor.check_stock(item1)
    assert_equal 12, vendor.check_stock(item2)
  end

  def test_sold_items
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    vendor.stock(item1, 30)
    vendor.stock(item1, 25)
    vendor.stock(item2, 12)

    items = [item1, item2]

    assert_equal items, vendor.sold_items
  end

  def test_potential_revenue
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    vendor.stock(item1, 2)
    vendor.stock(item2, 1)

    assert_equal 2.00, vendor.potential_revenue
  end
end
