$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib/cbs_sports'
require 'rubygems'
require 'yaml'
require 'sinatra'
require 'cbs_scores'

layout 'default.erb'
static '/iui', 'iui'

Sinatra::StaticEvent::MIME_TYPES.merge!({'js' => 'application/x-javascript'}) 


get "/" do
  get_scores
  get_winners

  erb :index, :layout => 'default.erb'
end

get "/search" do
  get_scores
  get_winners

  @games = []
  @scores.games.each do |game|
    @games << game if (game.team1[:name] =~ /#{params[:team]}/i || game.team2[:name] =~ /#{params[:team]}/i)
  end

  erb :search
end



private

def get_scores
  @scores = CbsScores.new(:mens_basketball)
end

def get_winners
  @winners = YAML::load( open("winners.yml") )[get_round].split(',')
end

def get_round
  rounds = { :round_1 => (Date.new(2008,3,20)..Date.new(2008,3,21)),
    :round_2 => (Date.new(2008,3,22)..Date.new(2008,3,23)),
    :round_3 => (Date.new(2008,3,27)..Date.new(2008,3,28)),
    :round_4 => (Date.new(2008,3,29)..Date.new(2008,3,30)),
    :round_5 => (Date.new(2008,4,5)..Date.new(2008,4,5)),
    :round_6 => (Date.new(2008,4,7)..Date.new(2008,4,7)) }

  rounds.each {|key,value| return key.to_s if value.include? Date.today }
  
end
