class BeerlistController < ApplicationController
  require 'will_paginate/array'
  def index
    @beerlist = beer
    @beer_count = beer.count
    @beerimage = beer_image
    
    (0...@beer_count).step(5).each do |index|
      @beerlist[index]['image'] = @beerimage.first['image']
      @beerlist[index+1]['image'] = @beerimage[1]['image']
      @beerlist[index+2]['image'] = @beerimage[2]['image']
      @beerlist[index+3]['image'] = @beerimage[3]['image']
      @beerlist[index+4]['image'] = @beerimage[4]['image']
    end

    @beerlist = @beerlist.paginate(:page => params[:page], :per_page=>20)
  end

  private

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def beer
    request_api(
      "https://s3-ap-southeast-1.amazonaws.com/he-public-data/beercraft5bac38c.json"
    )
  end

  def request_api_image(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def beer_image
    request_api_image(
      "https://s3-ap-southeast-1.amazonaws.com/he-public-data/beerimages7e0480d.json"
    )
  end

end
