# == Schema Information
#
# Table name: users
#
#  id                              :uuid             not null, primary key
#  email                           :string           not null, indexed
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string           indexed
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string           indexed
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  stripe_id                       :string           indexed
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_stripe_id             (stripe_id)
#

class User < ApplicationRecord
  authenticates_with_sorcery!

  # Relations
  has_many :torrents

  # Validations
  validates :email,    presence: true
  validates :email,    uniqueness: { case_sensitive: false }, email_format: true

  validates :password, presence: true, if: :password_required?
  validates :password, length: { minimum: 8 }, if: :password_required?

  def password_required?
    new_record? || changes[:crypted_password]
  end

  def usage
    torrents.sum(:size)
  end

  def quota
    20 * 1024 * 1024 * 1024
  end

  def expires_at
    Date.parse('2016-12-31')
  end
end
