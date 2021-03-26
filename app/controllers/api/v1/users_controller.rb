class Api::V1::UsersController < ApplicationController
    respond_to :json
    def show
        begin                   # bloco com rescue é similar ao try-catch
        @user = User.find(params[:id])
        respond_with @user
        rescue 
            head 404   
        end
    end    

    def create
        user = User.new(user_params)

        if user.save
            render json: user, status: 201      # json: user -> converte o user para hash json
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
