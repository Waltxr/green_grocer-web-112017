def consolidate_cart(cart)
  consolidated_hash = {}

  cart.each do |element|
    element.each do |item, info|
        consolidated_hash[item] = info
        info[:count] ||=0
        info[:count] +=1
    end
  end

  return consolidated_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    cart["#{coupon[:item]} W/COUPON"] = {
      :price=>coupon[:cost],
      :clearance=>cart[coupon[:item]][:clearance],
      :count => += 1
      # :count=>cart[coupon[:item]][:count] - coupon[:num]
    }
    cart[coupon[:item]][:count] -= coupon[:num]
  end

  return cart
end


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
