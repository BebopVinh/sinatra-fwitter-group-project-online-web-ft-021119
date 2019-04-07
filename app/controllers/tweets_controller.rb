class TweetsController < ApplicationController

   get '/tweets' do 
      if logged_in?
         @user = current_user
         erb :'/tweets/tweets'
      else
         redirect '/login'
      end
   end
    
   post '/tweets/new' do
      if logged_in?
         redirect '/tweets/new'
      else
         redirect '/login'
      end
   end

   get '/tweets/new' do
      if logged_in?
         erb :'/tweets/new'
      else
         redirect '/login'
      end
   end

   post '/tweets' do
      @user = User.find(session[:user_id])
      unless params[:tweet][:content].empty?
         @user.tweets << Tweet.new(params[:tweet])
         redirect "/users/#{@user.slug}"
      else
         redirect '/tweets/new'
      end
   end

   get '/tweets/:id' do
      if logged_in?
         @tweet = Tweet.find(params[:id])
         erb :'/tweets/show_tweet'
      else
         redirect '/login'
      end
   end

   post '/tweets/:id' do
      redirect "/tweets/#{param[:id]}/edit"
   end

   get '/tweets/:id/edit' do
      if logged_in?
         @tweet = Tweet.find(params[:id])
         erb :'/tweets/edit_tweet' if @tweet.user.id == session[:user_id]
      else
         redirect '/login'
      end
   end
   
   patch '/tweets/:id' do
      unless params[:tweet][:content].empty?
         @tweet = Tweet.find(params[:id])
         @tweet.update(params[:tweet])
         redirect "/tweets/#{@tweet.id}"
      else
         redirect "/tweets/#{params[:id]}/edit"
      end
   end

   delete '/tweets/:id' do
      if logged_in?
         @tweet = Tweet.find(params[:id])
         if @tweet.user.id == session[:user_id]
            @tweet.destroy
         end
      else
         redirect '/login'
      end
   end
end
