class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_many :events, dependent: :destroy
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations, source: :invitee

  def remove_attendance(event)
    attended_events.delete(event)
  end
end
