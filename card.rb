class Card
  attr_reader :face
  attr_accessor :value
  
  def initialize(face, value)
    @face = face
    @value = value
  end
end
