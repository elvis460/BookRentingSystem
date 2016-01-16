class SessionController < ApplicationController
  #session驗證登入
  def create
    user = User.find_by(name: params[:name])
    if user = user.try(:authenticate,params[:password])
      session[:user_id] = user.id
      message="welcome #{user.name}"
    else
      message="fail"
    end
    redirect_to "/book/index" , notice:message
  end
   #登出
  def destroy
    session.delete(:user_id)
    redirect_to "/book/index" , notice:'logout'

  end
end
