class User < ActiveRecord::Base
   has_secure_password
   has_many :tweets

   def slug
      self.username.downcase.gsub(/[^0-9a-z\- ]/, "")
   end

   def self.find_by_slug(name)
      user = User.find
   end
end