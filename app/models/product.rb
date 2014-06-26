class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	has_many :line_item

	before_destroy :ensure_not_referenced_by_any_line_item

	private

	def ensure_not_referenced_by_any_line_item
		if line_item.empty?
			return true
		else
			errors.add(:base, 'существуют товарные позиции')
			return false
		end
	end
end
