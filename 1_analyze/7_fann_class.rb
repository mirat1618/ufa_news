require 'ruby-fann'
require_relative '5_text_processable_module'

class FANNRecognizer
  include TextProcessable
  attr_accessor :models

  def initialize(path_to_dir)
    @models = Hash.new
    load_models(path_to_dir)
  end

  def load_models(path_to_dir)
    Dir.glob("#{path_to_dir}/*").each do |path|
      category = path.match(/.+_(.+)\./)[1]
      models[category] =  RubyFann::Standard.new(filename: path)
    end
  end

  def method_missing(message, *args)
    category = message.match(/is_((traffic)|(sport)|(gov))\?/)
    if category && args[0].is_a?(String)
      normalized_text_content = normalize_text_content(args[0])
      matches = compute_matches(normalized_text_content, category[1])
      @models[category[1]].run((matches)) == 1
    elsif !args[0].is_a?(String)
      raise ArgumentError, "#{args[0]} should be String"
    else
      raise NoMethodError, "#{message} is not defined."
    end
  end
end

article =  'В Оренбурге начался суд по иску прокуратуры в отношении министра финансов Татьяны Мошковой и ее сына
Сегодня в Ленинском суде Оренбурга начался судебный процесс по иску прокуратуры области к министру финансов региона Татьяны Мошковой и ее сына Карена Давтяна. Надзорное ведомство хочет взыскать с министра 30 миллионов рублей. Чиновница оказалась в числе подозреваемых в коррупции. «Прокуратурой области в Ленинский районный суд Оренбурга направлено исковое заявление об обращении в доход государства эквивалента стоимости имущества и обязательств имущественного характера, принадлежащих министру финансов Оренбургской области Татьяны Мошковой и ее близким родственникам, на общую сумму более 30 млн руб. Основанием для принятия мер реагирования послужили факты совершения сделок, которые существенно превышают законные доходы соответствующих лиц», —пишетУрал56.Ру со ссылкой на заместителя начальника отдела по надзору за исполнением законодательства о противодействии коррупции прокуратуры области Александра Хабибуллина. Арест на имущество Мошковой и ее сына уже наложен. В суде министр заявила, что не согласна с обвинением. А декларации о доходах есть в открытом доступе. Но прокуратура считает иначе. Глава надзорного ведомства отмечает, что расходы министра превышали доходы госслужащей. Прокуратура требует забрать у Мошковой квартиру в Москве, в которой сейчас проживает ее сын, в доход государства. Следующее заседание назначено на 8 сентября. Стоит отметить, что Татьяна Мошкова была назначена на должность министра финансов Оренбуржья еще в 2010 году, когда главой региона был еще Юрий Берг. И она одна из немногих, кто смог сохранить свою должность при смене власти. Когда губернатором области стал Денис Паслер, Мошкова работала в статусе врио, но после избавилась от приставки.
'

fann = FANNRecognizer.new('5_trained_models/2_fann/')

p fann.is_traffic?(article)
p fann.is_sport?(article)
p fann.is_gov?(article)
