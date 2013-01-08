class LoadFilesController < ApplicationController
  def index
  	@liability = Liability.new
  end

  def create
  	liability = Liability.new params[:liability]

  	path = File.join(Rails.root, "public/data", liability.file.original_filename)

  	File.open(path, "wb") { |f| f.write(liability.file.read) }

  	customerCollection = liability.create_by_file(path)

  	customerCollection.save
 	end
end
