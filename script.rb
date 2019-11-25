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

    def my_select
        if block_given?
          arr = []
          self.my_each do |x|
            if yield(x)
              arr << x
            end
          end
          arr
        end
        self
    end

    def my_all?(pattern = nil)
        if block_given?
          self.my_each do |x|
            return false unless yield(x)
          end
        elsif pattern != nil
          if pattern.is_a?(Class)
            self.my_each do |x|
              return false unless x.is_a?(pattern)
            end
          elsif pattern.is_a?(Regexp)
            self.my_each do |x|
              return false unless pattern.match(x.to_s)
            end
          else
            self.my_each do |x|
              return false unless x == pattern
            end
          end
        else
          self.my_each do |x|
            return false unless x
          end
        end
        true
    end

    def my_any?(path = nil)
        if block_given?
          self.my_each do |x|
            return true if yield(x)
          end
        elsif path != nil
          if path.is_a?(Class)
            self.my_each do |x|
              return true if x.is_a?(path)
            end
          elsif path.is_a?(Regexp)
            self.my_each do |x|
              return true if path.match(x.to_s)
            end
          else
            self.my_each do |x|
              return true if x == path
            end
          end
        else
          self.my_each do |x|
            return true if x
          end
        end
        false
      end

      def my_none?(pat = nil)
        if block_given?
          self.my_each do |x|
            return false if yield(x)
          end
        elsif pat != nil
          if pat.is_a?(Class)
            self.my_each do |x|
              return false if x.is_a?(pat)
            end
          elsif pat.is_a?(Regexp)
            self.my_each do |x|
              return false if pat.match(x.to_s)
            end
          else
            self.my_each do |x|
              return false if x == pat
            end
          end
        else
          self.my_each do |x|
            return false if x
          end
        end
        true
      end
  
  
  end
  