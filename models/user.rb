require 'data_mapper'
require 'dm-postgres-adapter'
require './data_mapper_setup'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,           Serial
  property :first_name,   String
  property :surname,      String
  property :email,        String
  property :password,     String

  has n, :links

end
