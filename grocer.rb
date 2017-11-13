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
  puts coupons
  coupons.each do |coupon|
    cart["#{coupon[:item]} W/COUPON"] = {
      :price=>coupon[:cost],
      :clearance=>cart[coupon[:item]][:clearance],
      :count => 
    }
    cart["#{coupon[:item]} W/COUPON"][:count] += 1
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
