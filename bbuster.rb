$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib/cbs_sports'
require 'rubygems'
require 'sinatra'
require 'cbs_scores'

layout 'default.erb'
static '/iui', 'iui'

Sinatra::StaticEvent::MIME_TYPES.merge!({'js' => 'application/x-javascript'}) 



get "/" do
  @scores = CbsScores.new(:mens_basketball)

  erb :index, :layout => 'default.erb'
end

get "/search" do
  @scores = CbsScores.new(:mens_basketball)
  @games = []

  @scores.games.each do |game|
    @games << game if (game.team1[:name] =~ /#{params[:team]}/i || game.team2[:name] =~ /#{params[:team]}/i)
  end

  erb :search
end

