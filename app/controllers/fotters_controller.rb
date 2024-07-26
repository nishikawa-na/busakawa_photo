class FottersController < ApplicationController
  skip_before_action :require_login
  def inquiry; end
  def policy; end
  def terms; end
end
