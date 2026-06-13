class ReviewsController < ApplicationController
  before_action :require_login, only: %i[ new create edit update destroy ]
  before_action :set_product, only: %i[ new create ]
  before_action :set_review, only: %i[ edit update destroy ]
  before_action :authorize_review, only: %i[ edit update destroy ]

  def new
    @review = @product.reviews.build
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: "Review was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review.product, notice: "Review was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    product = @review.product
    @review.destroy!
    redirect_to product, notice: "Review was successfully deleted."
  end

  private
    def set_product
      @product = Product.find(params.expect(:product_id))
    end

    def set_review
      @review = Review.find(params.expect(:id))
    end

    def authorize_review
      return if admin?
      return if @review.user_id == current_user.id

      flash[:notice] = "You are not authorized to modify that review."
      redirect_to @review.product
    end

    def review_params
      params.expect(review: [ :rating, :comment ])
    end
end
