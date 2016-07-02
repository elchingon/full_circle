module FullCircle
  class Builders::CouponBuilder
    def self.build(hash)
      coupon = Coupon.new(
        id: hash.fetch("id"),
        name: hash.fetch("name"),
        path_segment: hash['url'],
        begin: hash['begin'],
        expire: hash['expire'],
        accept_offline: hash['accept_offline'],
        accept_online: hash['accept_online'],
        accept_mobile: hash['acceptMobile'],
        accept_print: hash['acceptPrint'],
        offer: hash.fetch('offer'),
        restrictions: hash['restrictions']
      )
    end
  end
end
