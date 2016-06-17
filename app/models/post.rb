class Post < ActiveRecord::Base
	validates_presence_of :title
	belongs_to :user
	belongs_to :category
	has_many :comments, :dependent => :destroy

	delegate :name, :to => :category, :prefix => true, :allow_nil => true
end
