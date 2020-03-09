class User < ActiveRecord::Base
  has_secure_password
  validates :password, confirmation: true, length: { minimum: 3 }
  validates :email, uniqueness: {:case_sensitive => false}, presence:true
  validates :name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    if user
      if user.authenticate(password)
        user
      end
    end
  end
end
