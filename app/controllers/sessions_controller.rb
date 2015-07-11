class SessionsController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  # def index
  #   @sessions = Session.all
  # end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    # @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.authenticate(params[:session][:email],
                            params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  # def create
  #   user = User.find_by_email(params[:email])
  #   if user and user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     redirect_to homes_path, notice: 'Logged in successfully.'
  #   else
  #     redirect_to login_path, notice: 'Invalid Email or Password.'
  #   end
  # end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  # def update
  #   respond_to do |format|
  #     if @session.update(session_params)
  #       format.html { redirect_to @session, notice: 'Session was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @session }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @session.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    sign_out
    redirect_to root_path
    # @session.destroy
    # respond_to do |format|
    #   format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end
  # def user_email
  #   params[:user][:password]
  # end
  # def user_password
  #   parmas[:user][:password]
  # end
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_session
  #     @session = Session.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def session_params
  #     params[:session]
  #   end
end
