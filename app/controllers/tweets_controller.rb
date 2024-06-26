class TweetsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :set_tweet, only: [:update, :destroy, :show]
    
    def index
    
      if params[:search] == nil
        @tweets= Tweet.all
      elsif params[:search] == ''
        @tweets= Tweet.all
      else
      
        @tweets = Tweet.where("place LIKE ? ",'%' + params[:search] + '%')
      end

      @tweets = @tweets.page(params[:page]).per(5)
      @maps = Map.all
      @map = Map.new
    end
    
    
    
      def new
        @tweet = Tweet.new
      end
    
      def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = current_user.id 
        if @tweet.save
          redirect_to tweets_path, notice: 'Tweet was successfully created.'  # 適切なパスにリダイレクト
        else
          render :new
        end
      end
    

      def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
       
      end
      
      def edit
        @tweet = Tweet.find(params[:id])
      end
      
      
      def update
        
        @tweet = Tweet.find(params[:id])
        if @tweet.update(tweet_params)
          redirect_to :action => "show", :id => tweet.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        redirect_to action: :index


      end

    

      private

      def set_tweet
        @tweet = Tweet.find(params[:id])
      end

      def tweet_params
        params.require(:tweet).permit(:name, :date, :place, :genre, :organizer, :about, :lat, :lng, :address, :image_top, :images, :image)
      end

end
