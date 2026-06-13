class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :authorize_order, only: %i[ show edit update destroy ]

  def index
    @orders = if admin?
      Order.includes(:user).order(created_at: :desc)
    else
      current_user.orders.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @order = current_user.orders.build(email: current_user.email)
  end

  def edit
  end

  def create
    @order = current_user.orders.build(order_params)

    respond_to do |format|
      if @order.save
        @cart.cartitems.each do |item|
          item.update!(order_id: @order.id)
        end

        reset_cart

        format.html { redirect_to @order, notice: "Thank you for your order!" }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @order.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @order.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, notice: "Order was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params.expect(:id))
    end

    def authorize_order
      return if admin?
      return if @order.user_id == current_user.id

      flash[:notice] = "You are not authorized to view that order."
      redirect_to orders_path
    end

    def order_params
      params.expect(order: [ :name, :address, :email, :paytype ])
    end
end
