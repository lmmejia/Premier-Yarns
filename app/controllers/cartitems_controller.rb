class CartitemsController < ApplicationController
  before_action :set_cartitem, only: %i[ show edit update destroy ]

  # GET /cartitems or /cartitems.json
  def index
    @cartitems = Cartitem.all
  end

  # GET /cartitems/1 or /cartitems/1.json
  def show
  end

  # GET /cartitems/new
  def new
    @cartitem = Cartitem.new
  end

  # GET /cartitems/1/edit
  def edit
  end

  # POST /cartitems or /cartitems.json
  def create
    #come here if click "Add to Cart" button in shopper/index.html.erb
    #@cartitem = Cartitem.new(cartitem_params)

    product_id = params[:product_id]
    product_obj = Product.find(product_id)
    #cart_id = "check session to get cart_id"
    cart_obj = @cart #@cart is set by set_cart method in CurrentCart module

    #@cartitem = @cart.cartitems.build product: product_obj
    @cartitem = @cart.add_cartitem product_obj.id

    #redirect to @cart -> carts/id 
    respond_to do |format|
      if @cartitem.save
        format.html { redirect_to shopper_path, notice: "Added to cart." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @cartitem.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /cartitems/1 or /cartitems/1.json
  def update
    respond_to do |format|
      if @cartitem.update(cartitem_params)
        format.html { redirect_to @cartitem, notice: "Cartitem was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @cartitem }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @cartitem.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /cartitems/1 or /cartitems/1.json
  def destroy
    @cartitem.destroy!

    respond_to do |format|
      format.html { redirect_to cartitems_path, notice: "Cartitem was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cartitem
      @cartitem = Cartitem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def cartitem_params
      params.expect(cartitem: [ :cart_id, :product_id ])
    end
end
