module ApplicationHelper

	def icon(class_name)
		case class_name
      when "Page" then "content-page"
      when "Link" then "link"
      when "Folder" then "folder"
      else "gallery"
	  end
	end
end
