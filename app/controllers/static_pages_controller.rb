class StaticPagesController < ApplicationController
  def home
    @photos = []
    if params[:query]
      service = PexelApiService.new(params[:query])
      service.call
      @photos = service.photos
    end
  end
end
