class LoadFilesController < ApplicationController
  def index
  	@liability = Liability.new
  end

  def create
  	liability = Liability.new params[:liability]

  	path = File.join(Rails.root, "public/data", liability.file.original_filename)

  	File.open(path, "wb") { |f| f.write(liability.file.read) }

  	custumerCollection = liability.create_by_file(path)

  	custumerCollection.save
 	end
end
