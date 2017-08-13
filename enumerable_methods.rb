#!/usr/bin/env ruby
#
#

module Enumerable
    def my_each
      for element in self
          yield(element)
      end
      self
    end
    
    def my_each_with_index
      index = 0
      for element in self
        yield(element, index)
        index += 1
      end
      self
    end
    
    def my_select
        result = self.class == Hash ? {} : []
        if result.class == Hash
            my_each do |key, value|
                result[key] = value if value != nil && yield(key, value)
            end
        else
            my_each do |element|
                result << element if yield(element)
            end
        end
        result
    end
    
    def my_all?
        result = true
        if block_given?
            if self.class == Hash
                my_each do |key, value|
                    result = false unless yield(key,value)
                end
            else
                my_each do |element|
                    result = false unless yield(element)
                end
            end
        end
        result
    end
    
    def my_any?
        result = true
        if block_given?
            result = false
            if self.class == Hash
                my_each do |key, value|
                    if yield(key,value)
                        result = true
                        return result
                    end
                end
            else
                my_each do |element|
                    if yield(element)
                        result = true 
                        return result
                    end
                end
            end
        end
        result
    end
    
    def my_none?
    
    end
    
    def my_count
    
    end
    
    def my_map
      result = []
      my_each do |element|
        result << block.call(element)
      end
      result
    end
    
    def my_inject
        
    end
end