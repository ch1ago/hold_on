RSpec.describe HoldOn do
  it "has a version number" do
    expect(HoldOn::VERSION).not_to be nil
  end

  it "does something useful" do
    # expect(false).to eq(true)
  end
end

RSpec.describe HoldOn do
  describe "Simple (any context)" do
    def foo
      sleep 1
      1
    end

    def bar
      sleep 2
      2
    end

    def foobar
      sleep 3
      3
    end

    it "hold_on" do
      t = Time.now
      ret = hold_on(:foo, :bar, :foobar)
      t = (Time.now - t).to_i
      expect(t).to eq(3)
      # expect(ret).to eq([1, 2, 3])
      expect(ret).to eq({bar: 2, foo: 1, foobar: 3})

    end
  end
end

RSpec.describe HoldOn do
  describe 'Inheritance (MyObject < HoldOn)' do
    class MyObject < HoldOn
      def foo
        sleep 1
        1
      end

      def bar
        sleep 2
        2
      end

      def foobar
        sleep 3
        3
      end
    end

    it "hold_on" do
      t = Time.now
      ret = MyObject.new.hold_on
      t = (Time.now - t).to_i
      # expect(ret).to eq([1, 2, 3])
      expect(ret).to eq({bar: 2, foo: 1, foobar: 3})
      expect(t).to eq(3)
    end
  end
end
