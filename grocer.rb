def consolidate_cart(cart)
  consolidated_hash = {}

  # cart.each do |element|
  #   element.each do |item, info|
  #       consolidated_hash[item] = info
  #       info[:count] ||=0
  #       info[:count] +=1
  #   end
  # end

  cart.each do |element|
    element.each do |item, info|
      if consolidated_hash[item]
        consolidated_hash[item][:count] += 1
      else
        consolidated_hash[item] = info
        info[:count] ||=0
        info[:count] +=1
      end
    end
  end

  return consolidated_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart["#{coupon[:item]} W/COUPON"]
      cart["#{coupon[:item]} W/COUPON"][:count] +=1
    elsif cart.keys.include?(coupon[:item])
      cart["#{coupon[:item]} W/COUPON"] = {
        :price=>coupon[:cost],
        :clearance=>cart[coupon[:item]][:clearance],
        :count => 1
      }
    else
      return cart
    end
    cart[coupon[:item]][:count] -= coupon[:num]
  end

  return cart
end


def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      cart[item][:price] = cart[item][:price] - cart[item][:price] * 0.2
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  discounts_applied = apply_clearance(coupons_applied)

  price = 0.0
  discounts_applied.each do |item, info|
    price += discounts_applied[item][:price].to_f * discounts_applied[item][:count].to_f
  end

  if price > 100
    return price - price * 0.10
  else
    return price
  end
end

# it "only applies coupons that meet minimum amount" do
#   beer = find_item('BEER')
#   cart = Array.new(3, beer)
#   beer_coupon = find_coupon("BEER")
#   coupons = [beer_coupon, beer_coupon]
#   expect(checkout(cart, coupons)).to eq(33.00)
# end
# end

# cart = [{"BEER" => {:price => 13.00, :clearance => false}}, {"BEER" => {:price => 13.00, :clearance => false}}, {"BEER" => {:price => 13.00, :clearance => false}}]
coupons = [{:item => "BEER", :num => 2, :cost => 20.00}, {:item => "BEER", :num => 2, :cost => 20.00}]
