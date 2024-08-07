

# 払い出されるユーザ
class FakeUsersController < ApplicationController
  before_action :require_login

  before_action :set_fake_user, only: %i[ show edit update destroy ]

  # GET /fake_users or /fake_users.json
  def index
    @fake_users = FakeUser.all
  end

  # GET /fake_users/1 or /fake_users/1.json
  def show
  end

  # GET /fake_users/new
  def new
    @fake_user = FakeUser.new
  end

  # GET /fake_users/1/edit
  def edit
  end

  # POST /fake_users or /fake_users.json
  def create
    @fake_user = FakeUser.new(fake_user_params)

    respond_to do |format|
      if @fake_user.save
        format.html { redirect_to fake_user_url(@fake_user), notice: "Fake user was successfully created." }
        format.json { render :show, status: :created, location: @fake_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fake_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fake_users/1 or /fake_users/1.json
  def update
    respond_to do |format|
      if @fake_user.update(fake_user_params)
        format.html { redirect_to fake_user_url(@fake_user), notice: "Fake user was successfully updated." }
        format.json { render :show, status: :ok, location: @fake_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fake_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fake_users/1 or /fake_users/1.json
  def destroy
    @fake_user.destroy

    respond_to do |format|
      format.html { redirect_to fake_users_url, notice: "Fake user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fake_user
      @fake_user = FakeUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fake_user_params
      params.fetch(:fake_user, {})
    end
end
