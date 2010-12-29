class Geotag < ActiveRecord::Base
  attr_accessible :x, :y, :z
  has_many :sbickerls, :dependent => :destroy, :foreign_key => "id"
end
