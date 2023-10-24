class UsersController < ApplicationController
    before_action :authenticate_user!

    # for user with admin kind only
    # before_action :verify_kind, except: [:remember_me] 

    # before_action :set_user, only: [:show, :update]

    def index
        @users = User.where(kind: "user")
        
        render 'users/index'
    end

    def show
        render 'users/show'
    end

    def update
        if @user.update(user_params)
            render 'users/update'
        else 
            render json: { errors: user.errors }, status: :unprocessable_entity
        end
    end

    def remember_me
        user = current_user
        render json: user
    end

    private
    
    def verify_kind
        user = current_user
        if current_user.kind == "admin"
            return
        else
            render json: { error: "User is unauthorized to access this resource" }, status: :unauthorized
        end
    end
    
    def set_user
        @user = User.find_by(id: params[:id])
        if @user
            return
        else
            render json: { error: "User not found" }, status: :not_found
        end
    end

    def user_params 
        params.require(:user).permit(:full_name, :birthday, :personal_rate, :profile_picture, :status)
    end
end