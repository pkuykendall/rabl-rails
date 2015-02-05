require 'active_record'

class Post < ActiveRecord::Base
  has_many :comments, as: :commentable
end