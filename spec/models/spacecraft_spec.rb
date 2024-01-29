# spec/models/spacecraft_spec.rb
require 'rails_helper'

RSpec.describe Spacecraft, type: :model do
  let(:spacecraft) { Spacecraft.new }

  it 'is valid with valid attributes' do
    spacecraft = FactoryBot.build(:spacecraft)
    expect(spacecraft).to be_valid
  end

  it 'is not valid without x, y, z, or direction' do
    spacecraft = FactoryBot.build(:spacecraft, x: nil, y: nil, z: nil, direction: nil)
    expect(spacecraft).not_to be_valid
  end

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

  describe '#move_right' do
    it 'should move right correctly' do
      spacecraft.direction = 'N'
      spacecraft.move_right
      expect(spacecraft.direction).to eq('E')
    end
  end

  describe '#move_left' do
    it 'turns the spacecraft 90 degrees to the left' do
      spacecraft = Spacecraft.new(x: 0, y: 0, z: 0, direction: 'N')
      spacecraft.move_left
      expect(spacecraft.direction).to eq('W')
    end
  end

  describe '#move_up' do
    it 'turns the spacecraft upwards' do
      spacecraft = Spacecraft.new(x: 0, y: 0, z: 0, direction: 'N')
      spacecraft.move_up
      expect(spacecraft.direction).to eq('UP')
    end
  end

  describe '#move_down' do
    it 'turns the spacecraft downwards' do
      spacecraft = Spacecraft.new(x: 0, y: 0, z: 0, direction: 'Up')
      spacecraft.move_down
      expect(spacecraft.direction).to eq('Down'.downcase)
    end
  end
end
