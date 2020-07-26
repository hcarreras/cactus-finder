class Vehicle < ApplicationRecord
  validates :title, uniqueness: { scope: [:web_source, :location] }
end
