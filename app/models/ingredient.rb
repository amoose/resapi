class Ingredient
  include Mongoid::Document
  belongs_to :user
  belongs_to :data_source
end
