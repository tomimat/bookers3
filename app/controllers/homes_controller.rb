class HomesController < ApplicationController
  def top
  end

  def destroy
     reset_session
    redirect_to root_path
  end

  def about
  end

  def create
    @user = User.find(params[:id])

    if @user.sign_out
       flash[:notice] = "Signed out successfully."
      redirect_to about_path
    end
  end
end
