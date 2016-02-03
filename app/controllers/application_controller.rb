require_relative "../../config/environment"
require_relative "../models/candidate.rb" # change/add to account for name of models
# require "pry"

class ApplicationController < Sinatra::Base

  set :views, "app/views"

  set :public, "public" 
  #:public is no longer used to avoid overloading Module#public, use :public_folder or :public_dir instead
  #from /Users/julianne/Desktop/development/musicranker/app/controllers/application_controller.rb:12:in `<class:ApplicationController>'
  
  ##item-section-380547 > li:nth-child(1) > div > div.yt-lockup-content > h3 > a

  get "/" do

    array = Candidate.all
    @left = array.sample
    # until @left.party == "Democrat"
    #     @left = array.sample
    # end
    @right = array.sample
    # until @right.party == "Republican"
    #     @right = array.sample
    # end
    #puts @right.rating + @left.rating
    while @left == @right
      @right = array.sample
    end
    @left_rating = @left.rating.to_f
    @right_rating = @right.rating.to_f
    erb :index
  end

  post "/left" do
    @left_rating = params[:left_rating].to_f
    @right_rating = params[:right_rating].to_f
    @expected_outcome_left = 1/(1+10**((@right_rating - @left_rating)/400))

    @left_rating = @left_rating + 16 * (1 - @expected_outcome_left)
    @right_rating = @right_rating + 16 * (0 - (1 - @expected_outcome_left))


    @left_id = params[:left_id].to_i
    @right_id = params[:right_id].to_i
    Candidate.find(@left_id).update_attributes(rating: @left_rating.to_i)
    Candidate.find(@right_id).update_attributes(rating: @right_rating.to_i)
    redirect "/"
  end

  post "/right" do
    @left_rating = params[:left_rating].to_f
    @right_rating = params[:right_rating].to_f
    @expected_outcome_left = 1/(1+10**((@right_rating - @left_rating)/400))

    @left_rating = @left_rating + 16 * (0 - @expected_outcome_left)
    @right_rating = @right_rating + 16 * (1 - (1 - @expected_outcome_left))

    @left_id = params[:left_id].to_i
    @right_id = params[:right_id].to_i
    Candidate.find(@left_id).update_attributes(rating: @left_rating.to_i)
    Candidate.find(@right_id).update_attributes(rating: @right_rating.to_i)
    redirect "/"
  end

  get "/rank" do
    @array = Candidate.all
    @rankings = []
    rank = 1
    i = 3000
    until i == 0
      used = 0
      Candidate.all.each do |candidate|
        if candidate.rating == i
          @rankings << [candidate.name, candidate.rating.to_s, rank.to_s]
          used = used + 1
        end
      end
      if used != 0
        rank = rank + used
      end
      i = i - 1
    end

    @grey = true
    erb :rankings
  end

  get "/left" do
    redirect "/"
  end

  get "/right" do
    redirect "/"
  end

end