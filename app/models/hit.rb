class Hit < ActiveRecord::Base
	belongs_to :card
	belongs_to :buycard
end