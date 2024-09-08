class Friend < ApplicationRecord
	belongs_to :model, optional: true
	has_one_attached :photo
end
