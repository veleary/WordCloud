class App < ActiveRecord::Base
  attr_accessible :description, :name, :tag_list
  acts_as_taggable
end
