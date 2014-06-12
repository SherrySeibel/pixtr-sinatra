require "sinatra"
require "active_record"
require "pg"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
)

class Gallery < ActiveRecord::Base
  has_many :images

  # def images
  #   Image.where(gallery_id :self.id)
  # end
end

class Image < ActiveRecord::Base
end

get "/" do
  @galleries = Gallery.all
  erb :index
end

get "/galleries/new" do # dynamic bit to go before static.  
  erb :new_gallery
end

get "/galleries/:id" do
  @gallery = Gallery.find(params[:id]) 
  @images = @gallery.images

  erb :show
end

post "/galleries" do
  # gallery_params = params[:gallery]
  # gallery_name = gallery_params[:name]
  # # gallery_name = params[:gallery][:name]

  # Gallery.create(gallery_params)

  gallery = Gallery.create(params[:gallery])
  redirect "/galleries/#{gallery.id}"
end



# Below is code that was previously used, but discarded later. Some of it is notes

  # cat_images_in_app_rb = ["colonel_meow.jpg", "grumpy_cat.png"]
  # dog_images_in_app_rb = ["shibe.png"]

  # gallery_name = params[:gallery_name]
  # erb(gallery_name.to_sym, {
  #   locals: { # This is and optional hash (declares local variable names. cat_images and dog_images are variable names)
  #     cat_images: cat_images_in_app_rb, 
  #     dog_images: dog_images_in_app_rb } # This is an options hash
  # })

# get "/:gallery_name" do
#   gallery_name = params[:gallery_name]
#   erb(gallery_name.to_sym)
# end

 
#  get "/cats" do
#    erb :cats # will return string with file contents. This  
#  end 

#  get "/dogs" do
#   erb :dogs
# end