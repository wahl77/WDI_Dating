class Poke < ActiveRecord::Base
  belongs_to :poker, class_name: "User"
  belongs_to :pokee, class_name: "User"
  attr_accessible :viewed, :wink
end
