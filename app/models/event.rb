class Event < ApplicationRecord
  # associations
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', dependent: :destroy
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations, source: :invitee

  #validation
  validates :private, inclusion: { in: [true, false] }

  # scopes
  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :public_events, -> { where(private: false) }
  scope :private_events, -> { where(private: true) }
  
  def editable_by?(user)
    creator == user
  end

  def deletable_by?(user)
    creator == user
  end

  def invite(user)
    invitations.create(invitee: user)
  end

  def invited?(user)
    invitees.include?(user)
  end
end
