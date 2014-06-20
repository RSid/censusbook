require 'csv'

class CensusController < ApplicationController

# [{:state => 'alabama', :code =>1,:districts => [bcountyname => 'bar', bcountycode => 3]},{:state => 'florida', :code =>2,:districts => [qcountyname => 'reb', qcountycode => 4]}]


  def fips_processing
    states = []
    #[{name: 'alabama', code: 1},]

    CSV.foreach('/Users/sm1th/Dropbox/launchacademy/census/public/US_FIPS_Codes.csv', :headers => true, :col_sep => ',') do |row|
      states << {state_name: row['State'], state_code: row['FIPS_State'], counties: [] }
    end

    CSV.foreach('/Users/sm1th/Dropbox/launchacademy/census/public/US_FIPS_Codes.csv', :headers => true, :col_sep => ',') do |row|
      states.each do |state_info|
        if state_info[:state_name] == row['State']
          state_info[:counties].push( {county_name: row['County_Name'],county_code: row['FIPS_County']} )
        end
      end

    end

    @states = states.uniq
    # binding.pry

  end

  def index
    fips_processing
    @client = CensusApi::Client.new(ENV['CENSUS_API_KEY'], {vintage: 2010})
    @client.dataset = 'acs5' #might not contain pop'n data, just geo data

    user_location_code = ""

    @states.each do |state_info|
      if state_info[:state_name] == current_user.location.split(', ')[1]

        user_location_code = state_info[:state_code]
      end
    end

    search_term = 'state:'+ user_location_code

    @norwegian_born_people_in_user_state = @client.find('B05006_001E,B05006_010E', search_term)
    @norwegian_born_people_in_ma = @client.find('B05006_001E,B05006_010E','state:25')
    @norwegian_born_people_in_boston_area = @client.find('B05006_001E,B05006_010E','county:025','state:25')

  end

  def show


  end

  def new

  end

  def create

  end
end
