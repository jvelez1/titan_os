class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
