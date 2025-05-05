class User < ApplicationRecord
  has_many :user_apps, dependent: :destroy
  has_many :streaming_apps, through: :user_apps
  has_many :user_channel_programs, dependent: :destroy
  has_many :channel_programs, through: :user_channel_programs

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
