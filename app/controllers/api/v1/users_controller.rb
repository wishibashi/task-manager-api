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

end
