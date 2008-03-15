$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib/cbs_sports'
require 'rubygems'
require 'sinatra'
# require 'active_record'
require 'cbs_scores'
# require 'team'

# ActiveRecord::Base.establish_connection( 
#   :adapter => "mysql", 
#   :database => "bbuster",
#   :username => 'root',
#   :password => '',
#   :host => '127.0.0.1'
# ) 


get "/" do


# @team = Team.find(:all).each { |team| puts team }
@scores = CbsScores.new(:mens_basketball)

erb :index
end

