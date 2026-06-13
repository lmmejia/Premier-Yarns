class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ new create edit update destroy ]

  # GET /products or /products.json
  def index
    @search = params[:search].to_s.strip

    @products = if @search.present?
      Product.search_closest(@search)
    else
      Product.order(:name)
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    attach_image(@product)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    attach_image(@product)

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :description, :price ])
    end

    def attach_image(product)
      upload = params.dig(:product, :image_file)
      return if upload.blank?

      extension = File.extname(upload.original_filename).downcase
      return unless %w[ .gif .jpg .jpeg .png ].include?(extension)

      filename = "product_#{SecureRandom.hex(8)}#{extension}"
      directory = Rails.public_path.join("uploads", "products")
      FileUtils.mkdir_p(directory)
      File.binwrite(directory.join(filename), upload.read)

      product.remove_uploaded_image_file if product.image&.start_with?("uploads/")
      product.image = "uploads/products/#{filename}"
    end
end
