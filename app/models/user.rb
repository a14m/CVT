# == Schema Information
#
# Table name: users
#
#  id                 :uuid             not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string           not null, indexed
#  encrypted_password :string(128)      not null
#  confirmation_token :string(128)
#  remember_token     :string(128)      not null, indexed
#
# Indexes
#
#  index_users_on_email           (email)
#  index_users_on_remember_token  (remember_token)
#

class User < ApplicationRecord
  # Validations
  validates :email,    presence: true
  validates :email,    uniqueness: { case_sensitive: false }, email_format: true

  validates :password, presence: true
  validates :password, length: { minimum: 8 }
end
