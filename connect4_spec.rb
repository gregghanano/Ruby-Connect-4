require_relative 'connect4'

Rspec.describe Board do
  it "should check diagonal" do
    @@board = [
  							[nil, nil, nil, nil, nil, nil, nil],
  	            [nil, nil, nil, nil, nil, nil, nil],
  	            [nil, nil, nil, 'o', nil, nil, nil],
  	            [nil, nil, nil, 'x', 'o', nil, nil],
  	            [nil, nil, nil, 'o', 'x', 'o', nil],
  	            [nil, nil, nil, 'x', 'x', 'x', 'o']
  	      	]
    expect(self.check_wins(3, 'o')).to eq(true)
  end
end
