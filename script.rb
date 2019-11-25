module Enumerable
    def my_each
      counter = 0
      while counter < self.size
        yield(self[counter])
        counter += 1
       end
       self
    end
  
    def my_each
      index = 0
      while index < self.size
        yield(index, self[index])
        index += 1
       end
       self
    end
  
  
  
  end
  