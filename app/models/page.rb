class Page < ApplicationRecord
    has_one_attached :top_picture
    has_one_attached :left_picture
    has_one_attached :right_picture
    has_one_attached :bottom_picture
end
