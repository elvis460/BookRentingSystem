class Book < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :book_rents
end
