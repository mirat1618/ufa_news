require 'yaml'
require 'libsvm'

input = YAML.load(File.read('train_data_gov.yml'))

inputs = []
outputs = []
input.each {|array| inputs << array[0]; outputs << array[1]}

parameter = Libsvm::SvmParameter.new
parameter.cache_size = 1 # in megabytes
parameter.eps = 0.001
parameter.c = 1
parameter.gamma = 0.01
parameter.kernel_type = Libsvm::KernelType::RBF

inputs_formatted = inputs.map {|feature_row| Libsvm::Node.features(feature_row) }

problem = Libsvm::Problem.new
problem.set_examples(outputs, inputs_formatted)

model = Libsvm::Model.train(problem, parameter)

inputs.each.with_index do |matches, index|
  prediction = model.predict(Libsvm::Node.features(matches))
  puts "#{prediction.to_i} #{outputs[index]}"
end

model.save('svm.dat')
