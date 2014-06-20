class CensusController < ApplicationController
  #@client = CensusApi::Client.new(API_KEY)
  #@client = CensusApi::Client.new(ENV['CENSUS_API_KEY']) # from the environment variable

  def index
    @client = CensusApi::Client.new(ENV['CENSUS_API_KEY'], {vintage: 2010})
    @client.dataset = 'acs5' #might not contain pop'n data, just geo data

    @norwegian_born_people_in_ma = @client.find('B05006_001E,B05006_010E','state:25')
    @norwegian_born_people_in_boston_area = @client.find('B05006_001E,B05006_010E','county:025','state:25')

    if session['user_id'] != nil
      @current_user = User.find(session['user_id'])
    end

  end

  def show


  end

  def new

  end

  def create

  end
end
