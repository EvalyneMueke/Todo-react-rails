class ApplicationController < ActionController::API

    def encode_token(payload)
        JWT.encode(payload, "secret")
    end

    def decode_token
        #get token from header 
        auth_header = request.header['Authorization']
        #check whether token is present
        if auth_header
            # 'Bearer kffgrvcc' split(' ')[1]
            token = auth_header.split(' ')[1]
            #wrap the decoding process within an exception
            begin 
                JWT.decode(token, 'secret', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
          

    end

    def authorised_user
        #use decode token method to get user details
        decoded_token = decode_token()

        if decoded_token
             #take out user id
            user_id = decoded_token[0]['id']

            # [{payload},{header}, {verify_siganture}]

            # payload{
            #     "id":33
            #     "username":"eva"
            # }
       
        #find the user that matches the id
        #compare wat is provided to wat is in the database
        user = User.find_by(id: user_id)
    #     else
    #         render json:{error: "User not found"}, status: :not_found
       
    end
end

    
    def authorize
        render json:{message: "Unauthorized access"}, status: :unauthorized unless
        authorised_user
    end

end
