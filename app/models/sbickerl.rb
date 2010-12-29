class Sbickerl < ActiveRecord::Base
  attr_accessible :owner, :content, :visibility
  belongs_to :geotag, :primary_key => "id"
end
