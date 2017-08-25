require 'data_mapper'
require 'dm-postgres-adapter'
require './data_mapper_setup'

class Link
  include DataMapper::Resource

  property :id,        Serial
  property :title,     String
  property :url,       String

  has n, :tags, :through => Resource
  belongs_to :user

end
