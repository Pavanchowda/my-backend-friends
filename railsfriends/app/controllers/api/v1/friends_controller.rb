class Api::V1::FriendsController < ApplicationController
  # before_action :authenticate_user! # Ensure user is authenticated
  before_action :set_friend, only: [:show, :update, :destroy, :upload_photo]
  # before_action :set_friend, only: [:show, :update, :destroy]


  def upload_photo
    if params[:photo].present?
      @friend.photo.attach(params[:photo])

      if @friend.save
        render json: { message: 'Photo uploaded successfully' }, status: :ok
      else
        render json: { error: 'Failed to upload photo' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'No photo provided' }, status: :bad_request
    end
  rescue => e
    Rails.logger.error("Failed to upload photo: #{e.message}")
    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end

  # GET /api/v1/friends
  def index
    puts "Session user_id at friend controller: #{session.inspect}"
    
    @friends = Friend.where(user_id: params[:user_id]).paginate(page: params[:page], per_page: 5) 
    puts @friends.inspect
    render json: {
      friends: @friends.map { |friend| friend_response(friend) },
      current_page: @friends.current_page,
      total_pages: @friends.total_pages,
      total_entries: @friends.total_entries
    }
  end

  

  # GET /api/v1/friends/:id
  def show
    render json: friend_response(@friend)
  end

  # POST /api/v1/friends
  # POST /api/v1/friends
def create
  @friend = Friend.new(friend_params) # Use `new` instead of `build`

  if @friend.save
    render json: { success: true, friend: @friend }, status: :created
  else
    render json: { success: false, errors: @friend.errors.full_messages }, status: :unprocessable_entity
  end
end


  # PATCH/PUT /api/v1/friends/:id
  def update
    if @friend.update(friend_params)
      render json: @friend
    else
      render json: @friend.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/friends/:id
  def destroy
    @friend.destroy
    head :no_content
  end

  private

  def set_friend
    @friend = Friend.find(params[:id])
  end

  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter,:user_id, :model_id,:photo_url)
  end

  def friend_response(friend)
    # Create a hash and conditionally add the photo URL if the photo is attached
    response = friend.as_json
    response[:photo_url] = url_for(friend.photo) if friend.photo.attached?
    response
  end
end
