FactoryGirl.define do
  
  factory :game_guess do
    sequence(:id) {|n| "1#{n}" }
    game
    code "ABCD"
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
  end

end
