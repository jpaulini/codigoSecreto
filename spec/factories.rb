require 'bcrypt'

FactoryGirl.define do

  factory :user do
    id 10
    name 'nobody'
    password_digest BCrypt::Password.create('not4long')
    is_admin false
  end
  
  factory :admin, class: User do
    id 1
    name 'Admin'
    password_digest BCrypt::Password.create('secret')
    is_admin true
  end
  
  factory :game_guess do
    sequence(:id) {|n| "1#{n}" }
    game
    code "ABCF"
    result 1
  end
  
  factory :game_guess_won, class: GameGuess do
    sequence(:id) {|n| "1#{n}" }
    game
    code "CAFE"
    result 4
  end  

  factory :game do
    sequence(:id) {|n| "2#{n}" }
    secret_code "ZZZZ"
    
    factory :game_with_guesses do
      ignore do
        guess_count 5
      end
      
      after_create do |game, evaluator|
        FactoryGirl.create_list(:game_guess, evaluator.guess_count, game: game)
      end
      
    end
    
    factory :game_with_guesses_and_won do
      ignore do
        guess_count 5
      end
      
      after_create do |game, evaluator|
        FactoryGirl.create_list(:game_guess_won, evaluator.guess_count, game: game)
      end
      
    end
   
    
  end

end
