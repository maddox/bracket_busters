$:.unshift File.dirname(__FILE__) + '/lib'
require 'rubygems'
require 'sinatra'
require 'activerecord'
require 'cbs_scores'
require 'team'

ActiveRecord::Base.establish_connection( 
  :adapter => "mysql", 
  :database => "bbuster",
  :username => 'root',
  :password => '',
  :host => '127.0.0.1'
) 


get "/" do
  @scores = CbsScores.new(:mens_basketball)
  erb :index
end

