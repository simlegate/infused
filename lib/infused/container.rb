module Infused
  class Container
    def initialize
      @ctors_map = {}
    end
    
    def register(constructor, id = nil)
      if id.nil?
        @ctors_map[constructor.to_s.to_sym] = constructor
      else
        @ctors_map[id] = constructor
      end
    end

    def instantiate(id, *args, **kwargs)
      if has?(id)
        return @ctors_map[id].new(*args, **kwargs)
      else
        raise ConstructorNotRegisteredError.new
      end
    end
    
    def has?(id)
      @ctors_map.has_key?(id)
    end
    
    def add(implementation, id=nil)
      if not id
        sym = implementation.class.name.to_sym
        @ctors_map[sym] = implementation
      else
        @ctors_map[id] = implementation
      end
    end
    
    def get(id)
      @ctors_map[id]
    end
  end
end
