require 'yaml'
require 'ruby-fann'

def extract_dataset(path_to_dataset)
  input = YAML.load(File.read(path_to_dataset))
  inputs = []
  outputs = []
  input.each { |array| inputs << array[0]; outputs << [array[1]] }
  [inputs, outputs]
end

def save_model(trained_model, category, path)
  order_number = Dir.glob("#{path}/*").count + 1
  trained_model.save("#{path}/#{order_number}_#{category}.dat")
end

def test_model(extracted_dataset, trained_model, category)
  puts "----\n#{category.capitalize}\n----"
  inputs, outputs = extracted_dataset[0], extracted_dataset[1]
  i = 0.0
  inputs.each.with_index do |matches, index|
    prediction = trained_model.run(matches)
    puts "#{prediction} #{outputs[index]}"
    i += 1 if prediction[0].to_i == outputs[index][0]
  end
  puts "Total: #{inputs.count}; True predictions: #{i}. Quality: #{(i/inputs.count).round(4)}"
end

def train_model(extracted_dataset)
  inputs = extracted_dataset[0]
  outputs = extracted_dataset[1]
  num_inputs = inputs[0].count
  num_outputs = outputs[0].count

  train_data = RubyFann::TrainData.new(inputs: inputs, desired_outputs: outputs)
  model = RubyFann::Standard.new(num_inputs: num_inputs, hidden_neurons: [2,3,3], num_outputs: num_outputs)
  model.train_on_data(train_data, 1000, 10, 0.01)
  model
end

categories = ['traffic', 'sport', 'gov']

categories.each.with_index(1) do |category, index|
  extracted_dataset = extract_dataset("4_datasets/#{index}_#{category}_dataset.yaml")
  trained_model = train_model(extracted_dataset)
  #save_model(trained_model, category, '5_trained_models/2_fann/')
  test_model(extracted_dataset, trained_model, category)
end