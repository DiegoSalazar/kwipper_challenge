module Kwipper
  AuthenticationRequired = Class.new RuntimeError
  NotFoundError = Class.new RuntimeError
  EmptyRequest = Class.new RuntimeError
end