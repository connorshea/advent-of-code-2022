lines = File.readlines('day2input.txt')
# lines = File.readlines('day2testinput.txt')

# The winner of the whole tournament is the player with the highest score. Your
# total score is the sum of your scores for each round. The score for a single
# round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3
# for Scissors) plus the score for the outcome of the round (0 if you lost, 3
# if the round was a draw, and 6 if you won).

scores_for_selected_option = {
  rock: 1,
  paper: 2,
  scissors: 3
}

symbol_map = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors,
  'X' => :rock,
  'Y' => :paper,
  'Z' => :scissors
}

symbol_map_part_2 = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors,
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win
}

scores_for_result = {
  lose: 0,
  draw: 3,
  win: 6
}

# @param player_choice [Symbol] :rock, :paper, or :scissors
# @param opponent_choice [Symbol] :rock, :paper, or :scissors
# @return [Symbol] :win, :draw, or :lose
def determine_outcome(player_choice, opponent_choice)
  return :draw if player_choice == opponent_choice

  if player_choice == :rock
    return (opponent_choice == :paper) ? :lose : :win
  elsif player_choice == :scissors
    return (opponent_choice == :rock) ? :lose : :win
  elsif player_choice == :paper
    return (opponent_choice == :scissors) ? :lose : :win
  end
end

def determine_choice(opponent_choice, desired_result)
  return opponent_choice if desired_result == :draw

  if opponent_choice == :rock
    return (desired_result == :win) ? :paper : :scissors
  elsif opponent_choice == :scissors
    return (desired_result == :win) ? :rock : :paper
  elsif opponent_choice == :paper
    return (desired_result == :win) ? :scissors : :rock
  end
end

rounds = []

lines.each do |line|
  opponent_choice, player_choice = line.split(' ').map { |letter| symbol_map[letter] }

  round_score = 0

  # puts "player: #{player_choice}"
  # puts "opponent: #{opponent_choice}"
  outcome = determine_outcome(player_choice, opponent_choice)
  # puts outcome.inspect

  round_score += scores_for_selected_option[player_choice]
  round_score += scores_for_result[outcome]

  rounds << round_score
end

puts "Part 1 answer: #{rounds.sum}"

rounds = []

lines.each do |line|
  opponent_choice, desired_result = line.split(' ').map { |letter| symbol_map_part_2[letter] }

  round_score = 0

  # puts "opponent: #{opponent_choice}"
  # puts "desired_result: #{desired_result}"
  choice = determine_choice(opponent_choice, desired_result)
  # puts choice.inspect

  round_score += scores_for_selected_option[choice]
  round_score += scores_for_result[desired_result]

  rounds << round_score
end

puts "Part 2 answer: #{rounds.sum}"
