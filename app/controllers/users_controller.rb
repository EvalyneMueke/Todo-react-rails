class UsersController < ApplicationController
    def index
        users = User.all
        render json: users, status: :ok
    end
    def show
        user = User.find(params[:id])
        if user
            render json: user, status: :ok
        else
            render json: { error: "User not found"}, status: :not_found
        end
    end

    def create
        user = User.create!(user_params)
       if user.valid?
            render json: user, status: :created
       else
        
        render json: { errors:user.errors.full_messages}, status: :unprocessable_entity
        
        end
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user, status: :updated
        else
            render json:{error: "User not updated"},status: :not_found
        end

    end

    def destroy
        user = User.find(params[:id])
        if user
            user.destroy
            head :no_content
        else
          render json: {errors:"An error occured. Please try again"}, status: :not_found  
        end
    end

    def login 
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            token = encode_token({id: user.id})
            render json: {user: user, toke: token}, status: :ok
        else
            render json: { error:"Unauthorized"}, status: :unauthorized
        end
    end


    def get_all_user_tasks
        

    end
    #private 

    



    def user_params
        params.permit(
            :username, :password, :email, :gender
        
    )
    end

end
