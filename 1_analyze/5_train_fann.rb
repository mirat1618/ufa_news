require 'yaml'
require 'ruby-fann'

input = YAML.load(File.read('input_output.yml'))
inputs, outputs = [], []
input.each {|k,v| inputs << v[0]; outputs << [(v[1].to_f - 1)/(3-1)]}

# p inputs.count
# p outputs.count
#
train = RubyFann::TrainData.new(inputs: inputs, desired_outputs: outputs)
fann = RubyFann::Standard.new(num_inputs: 17, hidden_neurons: [2,3,3], num_outputs: 1)
fann.train_on_data(train, 1000, 10, 0.01)

inputs.each.with_index do |matches, index|
  outputs = outputs.flatten

  prediction = fann.run(matches)[0].round(3)
  puts "#{matches} #{prediction} #{outputs[index]}"
  #puts "#{prediction} #{outputs[index]}"
end

fann.save('fann.dat')
