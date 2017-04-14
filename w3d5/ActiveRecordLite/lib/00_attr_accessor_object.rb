class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # go through each name (symbol) passed in (ie :x, :y)
    names.each do |name|

      # convert name (:x) to correct format for instance_* method (:@x)
      instance_name = "@#{name}".to_sym

      # define the getter (:x)
      getter_name = name
      define_method(getter_name) do
        # pass expected argument (:@x)
        instance_variable_get(instance_name)
      end

      # define the setter (:x=)
      setter_name = "#{name}=".to_sym
      define_method(setter_name) do |set_value|
        # pass expected argument (@:x, set_value))
        instance_variable_set(instance_name, set_value)
      end
    end
  end
end
