module Kwipper
  AuthenticationRequired = Class.new RuntimeError
  EmptyRequestError = Class.new RuntimeError
  NoSuchViewError = Class.new ArgumentError
  NoSuchAction = Class.new RuntimeError
end