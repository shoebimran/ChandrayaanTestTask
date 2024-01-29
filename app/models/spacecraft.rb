class Spacecraft < ApplicationRecord
	validates_presence_of :x, :y, :z, :direction

  def move_right
    directions = %w[N E S W]
    current_index = directions.index(direction)
    self.direction = directions.rotate(1)[current_index]
  end

  def move_left
    directions = %w[N E S W]
    current_index = directions.index(direction) || 0 # Default to 0 if direction is not found
    self.direction = directions.rotate(-1).fetch(current_index, 'N')
  end

  def move_up
  	self.direction = 'UP'
	end

	def move_down
  	self.direction = 'down'
	end

	def move_forward
    self.y += 1 if direction == 'N'
    self.y -= 1 if direction == 'S'
    self.x += 1 if direction == 'E'
    self.x -= 1 if direction == 'W'
  end

  def move_backward
    case direction
    when 'N' then move_along_axis(:y, -1)
    when 'S' then move_along_axis(:y, 1, max_bound: 9_999_999)
    when 'E' then move_along_axis(:x, -1)
    when 'W' then move_along_axis(:x, 1)
    end
  end

  private

  def move_along_axis(axis, distance, max_bound: nil)
    current_position = send(axis)
    new_position = current_position - distance

    unless max_bound && !(-max_bound..max_bound).cover?(new_position)
      send("#{axis}=", new_position)
    end
  end
end
