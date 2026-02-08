class StaticPagesController < ApplicationController
  def home
    if params[:query]
      service = PexelApiService.new(params[:query])
      service.call
      @photos = service.photos unless service.photos.nil?
    end
  end
end
