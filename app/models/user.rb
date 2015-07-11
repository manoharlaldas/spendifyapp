class User < ActiveRecord::Base
  attr_accessor   :password, :password_confirmation
	has_many :expenses, dependent: :destroy
  has_attached_file :image, :styles => { :medium => "300*300", :thumb => "150*150>" }
  validates_attachment_content_type :image,
                                     :content_type => /\Aimage\/.*\Z/
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
	validates :email, presence: true, format: {with:VALID_EMAIL_REGEX}
	validates :password, presence: true, length: {minimum: 6}
	before_save :encrypt_password
	validates :password_confirmation, presence: true
    
    def has_password?(submitted_password)
       encrypted_password == encrypt(submitted_password)
    end


    class << self

     	def authenticate(email, submitted_password)
           user = find_by_email(email)
           (user && user.has_password?(submitted_password)) ? user : nil
        end

     	def authenticate_with_salt(id, cookie_salt)
          user = find_by_id(id)
          (user && user.salt == cookie_salt) ? user : nil
        end
    end

    private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
    	secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
    	Digest::SHA2.hexdigest(string)
    end
end
