require 'yaml'
require 'libsvm'

def extract_dataset(path_to_dataset)
  input = YAML.load(File.read(path_to_dataset))
  inputs = []
  outputs = []
  input.each { |array| inputs << array[0]; outputs << array[1] }
  [inputs, outputs]
end

def save_model(trained_model, category, path)
  order_number = Dir.glob("#{path}/*").count + 1
  trained_model.save("#{path}/#{order_number}_#{category}.dat")
end

def test_model(extracted_dataset, trained_model, category)
  puts "----\n#{category.capitalize}\n----"
  inputs, outputs = extracted_dataset[0], extracted_dataset[1]
  inputs.each.with_index do |matches, index|
    prediction = trained_model.predict(Libsvm::Node.features(matches))
    puts "#{prediction.to_i} #{outputs[index]}"
  end
end

def train_model(extracted_dataset)
  inputs = extracted_dataset[0]
  outputs = extracted_dataset[1]

  parameter = Libsvm::SvmParameter.new
  parameter.cache_size = 1 # in megabytes
  parameter.eps = 0.001
  parameter.c = 1
  parameter.gamma = 0.01
  parameter.kernel_type = Libsvm::KernelType::RBF
  inputs_formatted = inputs.map { |feature_row| Libsvm::Node.features(feature_row) }
  problem = Libsvm::Problem.new
  problem.set_examples(outputs, inputs_formatted)
  model = Libsvm::Model.train(problem, parameter)
end

categories = ['traffic', 'sport', 'gov']

categories.each.with_index(1) do |category, index|
  extracted_dataset = extract_dataset("4_datasets/#{index}_#{category}_dataset.yaml")
  trained_model = train_model(extracted_dataset)
  #save_model(trained_model, category, '5_trained_models/1_svm/')
  test_model(extracted_dataset, trained_model, category)
end