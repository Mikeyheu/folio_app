# # create.json.jbuilder
#This is the kind of json response that is required by jQuery-File-Upload
# # The required bits are buried somewhere in the jquery-file-download scripts
# json.array!([@image]) do |json, image|
#   json.name            	image.image_file
#   json.size            	image.image_file.size
#   json.current_path  		image.image_file.current_path
#   json.url           		image.image_file.url
#   json.thumbnail_url   	image.image_file.url(:thumb)
# end
