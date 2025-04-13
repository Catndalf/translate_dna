def translate_with_frame(dna, frames=[1,2,3,-1,-2,-3])

  revers_cod = { "A" => "T", "G" => "C", "T" => "A", "C" => "G"}
  
  hash_answers = Hash.new
  frames.each {|el| hash_answers[el] = nil} #заполниние хэша ключами в указнном в запросе порядке, что бы после вычеслений выдать корректный ответ
   
  
  if frames.any?(-3..-1) then #если был запрос для проверок -1, -2 и -3, то для них приозводятся подготовительные вычисления
    
    invert_dna = ""
    dna.each_char {|char| invert_dna << revers_cod[char]} #реверсирование ДНК по таблице реверсии   
  end
  
  #для каждого запроса который пришёл в переменнной frames будут выполненные нужные инструкции, результат которых будет добавлен в хэш, что бы потом выдать реузльтат в запрошенном порядке
  hash_answers[1] = frame_1(dna) if frames.include?(1)
  hash_answers[2] = frame_2(dna) if frames.include?(2)
  hash_answers[3] = frame_3(dna) if frames.include?(3)
  hash_answers[-1] = frame_4(invert_dna) if frames.include?(-1)
  hash_answers[-2] = frame_5(invert_dna) if frames.include?(-2)
  hash_answers[-3] = frame_6(invert_dna) if frames.include?(-3)
  

  
  out_array = hash_answers.inject([]){|result, (_, value)| result << value}#сбор всех значений в один массив
  end  
  
  def frame_1(dna)    
    dna = dna.scan(/.../)#разбивание входной строки на элементы массива, в которых по три буквы ДНК
    compilat_result(dna)
  end
  
  def frame_2(dna)     
    dna = dna.scan(/(?<=.).../)#без учёта первой буквы разбивание входной строки на элементы массива, в которых по три буквы ДНК
    compilat_result(dna)
  end
  
  def frame_3(dna)    
    dna = dna.scan(/(?<=..).../)#без учёта первых двух буквы разбивание входной строки на элементы массива, в которых по три буквы ДНК
    compilat_result(dna)
  end
  
  def frame_4(invert_dna)     
    invert_dna = invert_dna.reverse.scan(/.../)#обычная реверсия ранее инверсировнной строки и разбивание строки на элементы массива, в которых по три буквы ДНК 
    compilat_result(invert_dna)
  end
  
  def frame_5(invert_dna)
    invert_dna = invert_dna.reverse.scan(/(?<=.).../)#обычная реверсия ранее инверсировнной строки и без учёта первой буквы разбивание строки на элементы массива, в которых по три буквы ДНК 
    compilat_result(invert_dna)
  end
  
  def frame_6(invert_dna)  
    invert_dna = invert_dna.reverse.scan(/(?<=..).../)#обычная реверсия ранее инверсировнной строки и без учёта первых двух букв разбивание строки на элементы массива, в которых по три буквы ДНК 
    compilat_result(invert_dna)
  end
  
  def compilat_result(dna)
      #Таблица кодонов взята с сайта для расшфировки ДНК
      genetic_cod = {
      # Первый базис: T
      "TTT" => "F", "TTC" => "F", "TTA" => "L", "TTG" => "L",
      "TCT" => "S", "TCC" => "S", "TCA" => "S", "TCG" => "S",
      "TAT" => "Y", "TAC" => "Y", "TAA" => "*", "TAG" => "*",
      "TGT" => "C", "TGC" => "C", "TGA" => "*", "TGG" => "W",
      
      # Первый базис: C
      "CTT" => "L", "CTC" => "L", "CTA" => "L", "CTG" => "L",
      "CCT" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
      "CAT" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
      "CGT" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R",
      
      # Первый базис: A
      "ATT" => "I", "ATC" => "I", "ATA" => "I", "ATG" => "M",
      "ACT" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
      "AAT" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K",
      "AGT" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
      
      # Первый базис: G
      "GTT" => "V", "GTC" => "V", "GTA" => "V", "GTG" => "V",
      "GCT" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
      "GAT" => "D", "GAC" => "D", "GAA" => "E", "GAG" => "E",
      "GGT" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G"
    } 
    translated_dna = "" #техническая переменная для сбора последоветельности
    dna.each do |sequence| translated_dna << genetic_cod[sequence] end
    translated_dna
  end
  