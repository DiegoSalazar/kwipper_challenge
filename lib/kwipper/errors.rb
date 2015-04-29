module Kwipper
  AuthenticationRequired = Class.new RuntimeError
  NotFoundError = Class.new RuntimeError
  EmptyRequestError = Class.new RuntimeError
end