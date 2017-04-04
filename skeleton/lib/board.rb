class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) {[]}
    # @stone = stone
    # @cups.place_stone
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
    
    stones = @cups[start_pos].count
    @cups[start_pos].delete_if { |el| el == :stone }


  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
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
      return @player1.name
    elsif @cups[13].count < @cups[6].count
      return @player2.name
    elsif @cups[6].count == @cups[13].count
      return :draw
    end
  end
end
