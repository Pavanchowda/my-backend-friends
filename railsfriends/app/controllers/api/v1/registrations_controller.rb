class Api::V1::RegistrationsController < ApplicationController
  def create
    registration_params = params.require(:user).permit(:email, :password, :password_confirmation)
    
    @model = Model.new(registration_params) # Use the correct model name

    if @model.save
      render json: { message: "User registered successfully", success: true }, status: :created
    else
      render json: { error: @model.errors.full_messages.join(", "), success: false }, status: :unprocessable_entity
    end
  end
end
