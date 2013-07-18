class AuthenticatedController < ApplicationController
  before_filter :authenticate
end
