# encoding: utf-8
#
# Программа, которая генерирует визитку в html, используя шаблон
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Путь к файлу с шаблоном
template_path = File.dirname(__FILE__) + '/template.html'

unless File.exist?(template_path)
  abort "Не удалось найти шаблон"
end

# Считываем в пременную содержимое файла
template = File.read(template_path, encoding: 'UTF-8')

puts "Программа для создания визитки на основе ваших данных"
puts

# В хэш-массиве будем хранить введенные данные
answers = {}

# Спрашиваем данные
puts "Введите url фотографии:"
answers[:image_url] = gets.chomp

puts "Введите имя и фамилию"
answers[:name] = gets.chomp

puts "Введите должность"
answers[:employment] = gets.chomp

puts "Введите номер телефона"
answers[:phone] = gets.chomp

puts "Введите email"
answers[:email] = gets.chomp

# Вставляем данные в шаблон
answers.each do |field_name, user_input|
  template.gsub!("%{#{field_name}}", user_input)
end

# Сохраняем визитку в новый файл и сообщаем об этом пользователю
business_card_path = "#{answers[:name]} #{Time.now.strftime('%Y-%m-%d_%H-%M')}.html"

File.open(business_card_path, 'w:UTF-8') { |file| file.write template }
puts
puts "Ваша визитка сохранена в файл #{business_card_path}"


