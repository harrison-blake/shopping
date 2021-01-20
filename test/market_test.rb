require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)

    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
  end

  def test_instance_and_attributes
    market = Market.new("South Pearl Street Farmers Market")

    assert_instance_of Market, market
    assert_equal "South Pearl Street Farmers Market", market.name
    assert_equal [], market.vendors
  end

  def test_vendors
    vendors_array = [@vendor1, @vendor2, @vendor3]

    assert_equal vendors_array, @market.vendors
  end

  def test_vendor_names
    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @market.vendor_names
  end

  def test_vendors_that_sell
    vendor_array1 = [@vendor1, @vendor3]
    vendor_array2 = [@vendor2]

    assert_equal vendor_array2, @market.vendors_that_sell(@item4)
    assert_equal vendor_array1, @market.vendors_that_sell(@item1)
  end

  def test_get_items_point_to_hash
    answer_hash = {
                  @item1 => {:quantity => 0,
                             :vendors => []
                            },
                  @item2 => {:quantity => 0,
                             :vendors => []
                            },
                  @item3 => {:quantity => 0,
                             :vendors => []
                            },
                  @item4 => {:quantity => 0,
                             :vendors => []
                            }
                  }

    assert_equal answer_hash, @market.get_items_point_to_hash
  end

  def test_get_unique_items
    item_array = [@item1, @item2, @item3, @item4]

    assert_equal 4, @market.get_unique_items.length
  end

  def test_sorted_item_list
    expected = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]

    assert_equal expected, @market.sorted_item_list
  end

  def test_total_inventory
    answer_hash = {
                  @item1 => {:quantity => 100,
                             :vendors => [@vendor1, @vendor3]
                            },
                  @item2 => {:quantity => 7,
                             :vendors => [@vendor1]
                            },
                  @item3 => {:quantity => 25,
                             :vendors => [@vendor2]
                            },
                  @item4 => {:quantity => 50,
                             :vendors => [@vendor2]
                            }
                  }
      assert_equal answer_hash, @market.total_inventory
  end

  def test_overstocked_items
    assert_equal [@item1], @market.overstocked_items
  end
end
