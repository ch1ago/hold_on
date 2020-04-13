require "hold_on/version"

class HoldOn
  def hold_on
    methods = public_methods - self.class.superclass.instance_methods
    HoldOn.hold_on(self, *methods)
  end

  def HoldOn.hold_on(object, *methods)
    result = {}

    methods.map do |method|
      Thread.new { result[method] = object.send(method) }
    end.map(&:join)

    result
  end
end

class Object
  def hold_on(*methods)
    HoldOn.hold_on(self, *methods)
  end
end
