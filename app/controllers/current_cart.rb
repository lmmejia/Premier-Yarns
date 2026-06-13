module CurrentCart
    extend ActiveSupport::Concern

    def set_cart
        if logged_in?
            @cart = current_user.cart
            unless @cart
                guest_cart = Cart.includes(cartitems: :product).find_by(id: session[:cart_id], user_id: nil)
                if guest_cart
                    guest_cart.update!(user_id: current_user.id)
                    @cart = guest_cart
                else
                    @cart = current_user.create_cart!
                end
            end
            session[:cart_id] = @cart.id
        else
            @cart = Cart.includes(cartitems: :product).find_by(id: session[:cart_id], user_id: nil)
            unless @cart
                @cart = Cart.create
                session[:cart_id] = @cart.id
            end
        end
    end

    def reset_cart
        if logged_in?
            @cart&.cartitems&.destroy_all
        else
            session.delete(:cart_id)
            @cart = Cart.create
            session[:cart_id] = @cart.id
        end
    end
end
