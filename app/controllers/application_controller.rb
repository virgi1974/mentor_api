class ApplicationController < ActionController::API
  include ActionController::Serialization


  # rails-api gem leaves out some functionality we may need, like the modules
  # for Authentication(basic or with token) --> wich we´ll be using
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods


    after_filter :cors_set_access_control_headers
    before_filter :cors_preflight_check

    before_filter :authenticate_user_from_token, except: [:token]

    # we could implement a current_user-like  method like this, to restrict access
    # to the update/destroy actions ONLY for the author of the post/comment...
    before_action :check_self_user_from_token, except: [:token,:index,:show,:create]

    # before_filter :set_access_control_headers
    # def set_access_control_headers
    #   headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    # end

    # For all responses in this controller, return the CORS access control headers.

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.

    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '', :content_type => 'text/plain'
      end
    end

  # action to get an api_token from the client side, by sending our email+password
  # previously we should have created a registered user
    def token

      authenticate_with_http_basic do |email, password|
        user = User.find_by(email: email)
        if user &&  user.authenticate(password) 
          render json: { token: user.api_token }
        else
          render json: { error: 'Incorrect credentials' }, status: 401
        end

      end
    end

    private

  # because there is a before_filter for any controller`s action, we must deliver the api_token
  # for every request we make to the API

  # curl -H "Authorization: Token token=ead69cc668a226154f72cfa03f866cc6" http://localhost:3000/posts/1
    def authenticate_user_from_token
      unless authenticate_with_http_token { |token, options|  User.find_by(api_token: token) }
        render json: { error: 'Bad Token'}, status: 401
      end
    end



    def check_self_user_from_token
      name = self.controller_name

      comment_id = params[:id]
      author_id = choose_class(name,comment_id)

  binding.pry
      api_token = request.env["HTTP_AUTHORIZATION"].split("=").last[0..31]
      author_request_id = User.find_by(api_token: api_token).id

      unless author_id == author_request_id
  binding.pry
        render json: { error: 'user not allowed for this action'}, status: 401
      end
    end

    def choose_class name_controller,comment_id
      case name_controller
      when "comments"
        Comment.find_by(id:comment_id).user_id
      when "users"
        User.find_by(id:comment_id).id
      when "posts"
        Conversation.find_by(id:comment_id).user_id
      end
    end
end


