class MockMemcache < Hash
  alias :get :[]
  alias :set :[]=
end
