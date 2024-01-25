# spec/models/spacecraft_spec.rb
require 'rails_helper'

RSpec.describe Spacecraft, type: :model do
  describe '#move_forward' do
    it 'moves the spacecraft one step forward in the current direction' do
      spacecraft = Spacecraft.new(x: 0, y: 0, z: 0, direction: 'N')
      spacecraft.move_forward
      expect(spacecraft.y).to eq(1)
    end
  end

  describe '#move_backward' do
    it 'moves the spacecraft one step backward in the current direction' do
      spacecraft = Spacecraft.new(x: 0, y: 0, z: 0, direction: 'N')
      spacecraft.move_backward
      expect(spacecraft.y).to eq(1) # The spacecraft moves in the negative y direction
    end

    it 'does not move beyond the specified max bound in the positive y direction' do
      spacecraft = Spacecraft.new(x: 0, y: 9_999_999, z: 0, direction: 'S')
      spacecraft.move_backward
      expect(spacecraft.y).to eq(9_999_998) # Should not move beyond the boundary
    end

    it 'moves backward in the negative x direction' do
      spacecraft = Spacecraft.new(x: 1, y: 0, z: 0, direction: 'W')
      spacecraft.move_backward
      expect(spacecraft.x).to eq(0)
    end
  end
end
