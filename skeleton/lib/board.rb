
require'byebug'
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {[]}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_index do |i|
      next if i == 6 || i == 13
      4.times do
        @cups[i] << :stone
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(1, 12)
  end

  def make_move(start_pos, current_player_name)

    stones = @cups[start_pos]
    @cups[start_pos] = []

    cup_idx = start_pos

    until stones.empty?
      cup_idx += 1
      cup_idx = 0 if cup_idx > 13

      if cup_idx == 6
        if current_player_name == @name1
          @cups[6] << stones.pop
        end
      elsif cup_idx == 13
        if current_player_name == @name2
          @cups[13] << stones.pop
        end
      else
        @cups[cup_idx] << stones.pop
      end
    end

    render
    next_turn(cup_idx)

  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].count == 1
      return :switch
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if @cups[0..5].all?(&:empty?)
    return true if @cups[7..12].all?(&:empty?)
    false
  end

  def winner
    if @cups[13].count > @cups[6].count
      return @name2
    elsif @cups[13].count < @cups[6].count
      return @name1
    elsif @cups[6].count == @cups[13].count
      return :draw
    end
  end
end
