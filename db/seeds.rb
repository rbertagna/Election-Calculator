require_relative "../app/models/candidate.rb"
require_relative "../app/models/view.rb"

  Candidate.create( :name => "Donald Trump", :party => "Republican", :state => "N/A", :img_url => "http://media3.s-nbcnews.com/j/newscms/2015_33/1165401/150810-donald-trump-debate-743a_ded2a0af932f2c2332757273ea911da2.nbcnews-fp-1200-800.jpg", :rating => 770)
  Candidate.create( :name => "Ted Cruz", :party => "Republican", :state => "Texas", :img_url => "http://crooksandliars.com/files/primary_image/16/01/tedcruz3_0.jpg", :rating => 633)
  Candidate.create( :name => "Marco Rubio", :party => "Republican", :state => "Florida", :img_url => "http://floridapolitics.com/wp-content/uploads/2015/05/MarcoRubio1.jpg", :rating => 948)
  Candidate.create( :name => "Ben Carson", :party => "Republican", :state => "N/A", :img_url => "http://www.motherjones.com/files/carsonposing.jpg", :rating => 889)
  Candidate.create( :name => "Jeb Bush", :party => "Republican", :state => "Florida", :img_url => "http://rightweb.irc-online.org/images/uploads/jeb-bush-foreign-policy.jpg", :rating => 1011)
  Candidate.create( :name => "Chris Christie", :party => "Republican", :state => "New Jersey", :img_url => "http://energyfuse.org/wp-content/uploads/2015/06/christie.jpg", :rating => 863)
  Candidate.create( :name => "John Kasich", :party => "Republican", :state => "Ohio", :img_url => "https://cmgddnohiopolitics.files.wordpress.com/2015/08/john-kasich.jpg", :rating => 887)
  Candidate.create( :name => "Carly Fiorina", :party => "Republican", :state => "N/A", :img_url => "http://static.politifact.com.s3.amazonaws.com/politifact%2Fphotos%2Ffiorina_cnn_debate.jpg", :rating => 651)

  Candidate.create( :name => "Hilary Clinton", :party => "Democrat", :state => "New York", :img_url => "http://www.nationofchange.org/2015/wp-content/uploads/hillary-clinton-iowa1.jpg", :rating => 534)   
  Candidate.create( :name => "Bernie Sanders", :party => "Democrat", :state => "Vermont", :img_url => "http://www.motherjones.com/files/bernie_2.jpg", :rating => 606)   
