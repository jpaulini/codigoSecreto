class User < ActiveRecord::Base
validates :name, presence: true, uniqueness: true
has_secure_password
has_many :games,  dependent: :destroy
end
