class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :pokemons, dependent: :destroy
  has_many :bookings

  def image_path
    case gender
    when 'male' then 'james.png'
    when 'female' then 'jessie.png'
    else
      'meowth.png'
    end
  end
end
