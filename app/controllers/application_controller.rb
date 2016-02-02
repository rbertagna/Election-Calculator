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
    # Candidate.create( :name => "Donald Trump", :party => "Republican", :state => "N/A", :img_url => "http://media3.s-nbcnews.com/j/newscms/2015_33/1165401/150810-donald-trump-debate-743a_ded2a0af932f2c2332757273ea911da2.nbcnews-fp-1200-800.jpg", :rating => 800)
    # Candidate.create( :name => "Ted Cruz", :party => "Republican", :state => "Texas", :img_url => "http://crooksandliars.com/files/primary_image/16/01/tedcruz3_0.jpg", :rating => 800)
    # Candidate.create( :name => "Marco Rubio", :party => "Republican", :state => "Florida", :img_url => "http://floridapolitics.com/wp-content/uploads/2015/05/MarcoRubio1.jpg", :rating => 800)
    # Candidate.create( :name => "Ben Carson", :party => "Republican", :state => "N/A", :img_url => "http://www.motherjones.com/files/carsonposing.jpg", :rating => 800)
    # Candidate.create( :name => "Jeb Bush", :party => "Republican", :state => "Florida", :img_url => "http://rightweb.irc-online.org/images/uploads/jeb-bush-foreign-policy.jpg", :rating => 800)
    # Candidate.create( :name => "Rand Paul", :party => "Republican", :state => "Kentucky", :img_url => "https://usatelections.files.wordpress.com/2014/04/randpaul.jpg?w=1000&h=667", :rating => 800)
    # Candidate.create( :name => "Chris Christie", :party => "Republican", :state => "New Jersey", :img_url => "http://energyfuse.org/wp-content/uploads/2015/06/christie.jpg", :rating => 800)
    # Candidate.create( :name => "Mike Huckabee", :party => "Republican", :state => "Arkansas", :img_url => "http://newshour-tc.pbs.org/newshour/wp-content/uploads/2015/05/RTR4XVOP-1024x683.jpg", :rating => 800)
    # Candidate.create( :name => "John Kasich", :party => "Republican", :state => "Ohio", :img_url => "https://cmgddnohiopolitics.files.wordpress.com/2015/08/john-kasich.jpg", :rating => 800)
    # Candidate.create( :name => "Carly Fiorina", :party => "Republican", :state => "N/A", :img_url => "http://static.politifact.com.s3.amazonaws.com/politifact%2Fphotos%2Ffiorina_cnn_debate.jpg", :rating => 800)
    # Candidate.create( :name => "Rick Santorum", :party => "Republican", :state => "Pennsylvania", :img_url => "http://www.rightwingwatch.org/sites/default/files/images/a_story_images/rick-santorum_1.jpg", :rating => 800)

    # Candidate.create( :name => "Hilary Clinton", :party => "Democrat", :state => "New York", :img_url => "http://www.nationofchange.org/2015/wp-content/uploads/hillary-clinton-iowa1.jpg", :rating => 800)   
    # Candidate.create( :name => "Bernie Sanders", :party => "Democrat", :state => "Vermont", :img_url => "http://www.motherjones.com/files/bernie_2.jpg", :rating => 800)   
    # Candidate.create( :name => "Martin O'Malley", :party => "Democrat", :state => "Maryland", :img_url => "http://floridapolitics.com/wp-content/uploads/2015/11/martin-omalley-photo.jpg", :rating => 800)   

    array = Candidate.all
    @left = array.sample
    until @left.party == "Democrat"
        @left = array.sample
    end
    @right = array.sample
    until @right.party == "Republican"
        @right = array.sample
    end
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

    @left_rating = @left_rating + 8 * (1 - @expected_outcome_left)
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

    @left_rating = @left_rating + 8 * (0 - @expected_outcome_left)
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