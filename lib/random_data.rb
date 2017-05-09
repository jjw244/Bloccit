# #5 RandomData is a standalone library with no dependencies or inheritance requirements
 module RandomData
 # #6  random_paragraph -> create 4-6 random sentences and append them to the sentences array
   def self.random_paragraph
     sentences = []
     rand(4..6).times do
       sentences << random_sentence
     end

     sentences.join(" ")
   end

 # #7  random_sentence -> create 3-8 random words and append them to the strings array
   def self.random_sentence
     strings = []
     rand(3..8).times do
       strings << random_word
     end

     sentence = strings.join(" ")
     sentence.capitalize << "."
   end

 # #8  random_word -> set a-z to an array, shuffle the array in place, join 0th-nth letters
  #nth -> rand(3..8) returns a random number <= 3 and > 8
   def self.random_word
     letters = ('a'..'z').to_a
     letters.shuffle!
     letters[0,rand(3..8)].join
   end

   def self.random_number
     rand(4..6)
   end
 end
