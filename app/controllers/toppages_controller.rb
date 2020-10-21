class ToppagesController < ApplicationController
  def index
    @subjects = Subject.order(id: :desc).page(params[:page])
  end
end
