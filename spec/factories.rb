FactoryGirl.define do
  
  factory :game_guess do
    id
    game
    code "ABCD"
  end  

  factory :game do
    id "23"
    secret_code "ZZZZ"
    
    factory :game_with_guesses do
      ignore do
        guesses_count 5
      end
      
      after_create do |game, evaluator|
        FactoryGirl.create_list(:game_guess, evaluator.guess_count, game: game)
      end
    
    end
  end

end
