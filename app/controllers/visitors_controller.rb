class VisitorsController < ApplicationController
  
  def new
    @visitor = Visitor.new
  end
  
  def create
    @visitor = Visitor.new(secure_params)
    if @visitor.valid?
      @visitor.subscribe
      flash[:notice] = "You're signed up!"
      redirect_to root_path
    else
      render 'new'
      flash[:notice] = "Damn, that didn't work.  Better try again."
    end
  end
  
  private
  
  def secure_params
    params.require(:visitor).permit(:email)
  end
  
  
end
