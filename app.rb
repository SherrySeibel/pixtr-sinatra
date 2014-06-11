require "sinatra"
require "active_record"
require "pg"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery")

class Gallery < ActiveRecord::Base
end



get "/" do
@galleries = Gallery.all
erb :index
end

get "/galleries/:id" do
  cat_images_in_app_rb = ["colonel_meow.jpg", "grumpy_cat.png"]
  dog_images_in_app_rb = ["shibe.png"]

  gallery_name = params[:gallery_name]
  erb(gallery_name.to_sym, {
    locals: { # This is and optional hash (declares local variable names. cat_images ad dog_images are variable names)
      cat_images: cat_images_in_app_rb, 
      dog_images: dog_images_in_app_rb } # This is an options hash
  })
end

# get "/:gallery_name" do
#   gallery_name = params[:gallery_name]
#   erb(gallery_name.to_sym)
# end

 
#  get "/cats" do
#    erb :cats # will return string with file contents 
#  end 

#  get "/dogs" do
#   erb :dogs
# end