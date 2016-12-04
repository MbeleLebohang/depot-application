require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be posetive" do
    product = Product.new(
      title: "Apples",
      description: "This are apples alright",
      image_url: "apples.jpg"
    )

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert_equal ["must be greater than or equal to 0.01"],product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{name.jpg name.png name.gif NAME.JPG NAME.PNG NAME.GIF https://a.b.com/x/y/name.gif}
    bad = %w{name.more name.gif/more}

    ok.each do |url|
      assert new_product(url).valid?, "#{url} shouldn't be invalid"
    end

    bad.each do |url|
      assert new_product(url).invalid?, "#{url} should be invalid"
    end
  end

  test "product is not valid without unique title" do
    product = Product.new(
                         title: products(:ruby).title,
                         description: "This is tuna alright!",
                         price: 20.30,
                         image_url: "fish.gif"
    )
    assert product.invalid?
    #assert_equal ["has already been taken"], product.errors[:title]
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end


  private
  def new_product(url)
    Product.new(title: "Apples",
              description: "This is tuna alright!",
              price: 20,
              image_url: url )
  end

end
