require "sinatra"
require "active_record"
require "pg"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
)

class Gallery < ActiveRecord::Base
  has_many :images, dependent: :destroy
end

class Image < ActiveRecord::Base
end

get "/" do
  @galleries = Gallery.all
  erb :index
end

get "/galleries/new" do 
  erb :new_gallery
end

get "/galleries/:id" do
  @gallery = Gallery.find(params[:id]) 
  @images = @gallery.images

  erb :show
end

post "/galleries" do
  gallery = Gallery.create(params[:gallery])
  
  redirect "/galleries/#{gallery.id}"
end

get "/galleries/:id/edit" do
  @gallery = Gallery.find(params[:id])
  
  erb :edit_gallery
end

patch "/galleries/:id" do
  gallery = Gallery.find(params[:id])

  gallery.update(params[:gallery])

  redirect "/galleries/#{gallery.id}"
end

delete "/galleries/:id" do
  gallery = Gallery.find(params[:id])

  gallery.destroy
  
  redirect "/"
end

get "/galleries/:gallery_id/images/new" do
  @gallery = Gallery.find(params[:gallery_id])
  
  erb :new_image
end

post "/galleries/:gallery_id/images" do
  image_params = params[:image]
  hash_with_gallery_id = { gallery_id: params[:gallery_id] }
  combined_hash_with_everything = image_params.merge(hash_with_gallery_id)

  Image.create(combined_hash_with_everything)

  redirect "/galleries/#{params[:gallery_id]}"
end



