class Api::V1::PasswordsController < ApplicationController
  # POST /api/v1/forgot-password
  def forgot_password
    @model = Model.find_by(email: params[:email])
    if @model
      # Assuming you have a method to send the reset password email
      @model.send_reset_password_instructions
      render json: { message: 'Password reset link has been sent to your email.' }, status: :ok
    else
      render json: { error: 'Email not found.' }, status: :not_found
    end
  end
end
