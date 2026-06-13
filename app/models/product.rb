
class Product < ApplicationRecord
    validates( :name, :description, :image, :price, presence: true)
    validates( :price, numericality: { greater_than_or_equal_to: 0.01 })
    validates(:image, format: {
      with: %r(\A(?:uploads/products/)?[\w.-]+\.(?:gif|jpe?g|png)\z)i,
      message: "must be a GIF, JPG, or PNG image."
    })
    validates(:name, uniqueness: true)

    has_many :cartitems, dependent: :destroy
    has_many :reviews, dependent: :destroy

    before_destroy :make_sure_no_cart_items_under_this_product
    before_destroy :remove_uploaded_image_file

    def average_rating
      return nil if reviews.empty?

      reviews.average(:rating).to_f.round(1)
    end

    def image_url
      if image.start_with?("uploads/")
        "/#{image}"
      else
        image
      end
    end

    def self.search_closest(term)
      query = term.to_s.strip.downcase
      return none if query.blank?

      escaped = sanitize_sql_like(query)

      exact = where("LOWER(name) = ?", query).order(:name)
      return exact if exact.exists?

      starts_with = where("LOWER(name) LIKE ?", "#{escaped}%").order(:name)
      return starts_with if starts_with.exists?

      matching = where("LOWER(name) LIKE ?", "%#{escaped}%").order(:name).to_a
      return none if matching.empty?

      word_matches = matching.select do |product|
        product.name.downcase.split(/\s+/).any? do |word|
          word == query || word.start_with?(query)
        end
      end

      best_matches = word_matches.any? ? word_matches : matching
      where(id: best_matches.map(&:id)).order(:name)
    end

    def make_sure_no_cart_items_under_this_product
        if self.cartitems.empty?
            return true
        else
            return false
        end
    end

    def remove_uploaded_image_file
      return unless image&.start_with?("uploads/")

      path = Rails.public_path.join(image)
      File.delete(path) if File.exist?(path)
    end

end
