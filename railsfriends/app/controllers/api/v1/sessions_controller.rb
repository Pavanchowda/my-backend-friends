class Api::V1::SessionsController < ApplicationController
  def create
    @model = Model.find_by(email: session_params[:email])
    
    if @model
      puts "User found: #{@model.email}"
      if @model.valid_password?(session_params[:password])
        puts "Password valid"
        session[:user_id] = @model.id
        puts "Session after setting user_id: #{session.inspect}"
        render json: { message: "User logged in successfully", success: true, user_id: @model.id }
      else
        puts "Invalid password"
        render json: { error: "Login is invalid", success: false }
      end
    else
      puts "User not found"
      render json: { error: "Login is invalid", success: false }
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
