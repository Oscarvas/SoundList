class SessionsController < ApplicationController
  def new
  	redirect_to '/auth/spotify'
  end

  def create
  	auth = request.env["omniauth.auth"]
  	user = User.where(:provider => auth['provider'],
  		:uid => auth['uid']).first || User.create_with_omniauth(auth)
  	session[:user_id] = user.id

  	if !user.email
  		redirect_to edit_user_path(user), :alert => 'Please enter your email address.'
	else
  		redirect_to user, :notice => 'Signed in!'#esto deberia redirigir a root_path
  	end 

  end

  def failure
  	redirect_to root_url, :alert => "Error en la autenticacion: #{params[:message].humanize}"
  end

  def destroy
  	reset_session
  	redirect_to root_url, :notice => 'Signed out!'
  end

end