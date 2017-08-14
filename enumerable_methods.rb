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
    result = true
    if block_given?
      if self.class == Hash
        my_each do |key, value|
          if yield(key,value)
            result = false
            return result
          end
        end
      else
        my_each do |element|
          if yield(element)
            result = false 
            return result
          end
        end
      end
    end
    result
  end

  def my_count(*i)
    result = 0
    #if a block is passed, count all occurances where the block evaluates to true
    if block_given?
      my_each do |element|
        result += 1 if yield(element)
      end
    else
      #if an argument is passed, count occurances of the argument, else count all elements
      my_each do |element| element == (i ? i : element)
        result += 1
      end
    end
    result
  end

  def my_map(proc = nil)
    result = []
    my_each do |element|
      #execute proc if present, else yield
      result << (proc ? proc.call(element): yield(element))
    end
    result
  end

  def my_inject(memo = nil)
    temp = self.dup.to_a
    unless memo
      memo = temp.first
      temp.shift
    end
    temp.my_each do |element|
      memo = yield(memo, element)
    end
    memo
  end
  
  def multiply_els
    my_inject(1) { |product, n| product * n }
  end
  
end