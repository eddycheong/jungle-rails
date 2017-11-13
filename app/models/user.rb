class User < ActiveRecord::Base

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
  has_secure_password

  has_many :reviews

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: strip_whitespace(email))

    if user && user.authenticate(password)
      return user
    end

    nil
  end

  protected
    def self.strip_whitespace(email)
      email.strip
    end

end
