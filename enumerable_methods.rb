#!/usr/bin/env ruby
#
#

module Enumerable
    def my_each(&block)
        for element in self
            yield(element)
        end
        self
    end
    
    def my_each_with_index(&block)
        index = 0
        for element in self
            yield(element, index)
            index += 1
        end
        self
    end
    
    def my_select
    
    end
    
    def my_all?
    
    end
    
    def my_any?
    
    end
    
    def my_none?
    
    end
    
    def my_count
    
    end
    
    def my_map
        
    end
    
    def my_inject
        
    end
    
    
    
    
    
end
        