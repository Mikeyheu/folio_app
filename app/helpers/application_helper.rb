module ApplicationHelper
  include ActionView::Helpers::UrlHelper

	def icon(class_name)
		case class_name
      when "Page" then "content-page"
      when "Link" then "link"
      when "Folder" then "folder"
      else "gallery"
	  end
	end

	def navlink(site,item)

		class_name = item.class.name

    if class_name ==  "Page" 
    	link_to item.name, admin_site_page_path(site, item), class: 'ajax'
    else 
      item.name
	  end
	end

  def deletelink(site, item)

    class_name = item.class.name

    if class_name ==  "Page" 
      link_to '<i class="icon-nav menu-close"></i>'.html_safe, admin_site_page_path(site, item), method: :delete, data: { confirm: 'Are you sure?' }, class: 'close-button'
    elsif class_name ==  "Link" 
      link_to '<i class="icon-nav menu-close"></i>'.html_safe, admin_site_link_path(site, item), method: :delete, data: { confirm: 'Are you sure?' }, class: 'close-button'
    elsif class_name ==  "Folder" 
      link_to '<i class="icon-nav menu-close"></i>'.html_safe, admin_site_folder_path(site, item), method: :delete, data: { confirm: 'Are you sure?' }, class: 'close-button'
    elsif class_name ==  "Gallery" 
      link_to '<i class="icon-nav menu-close"></i>'.html_safe, admin_site_gallery_path(site, item), method: :delete, data: { confirm: 'Are you sure?' }, class: 'close-button'
    end
  end

  def settingslink(site, item)

    class_name = item.class.name

    if class_name ==  "Page" 
      link_to '<i class="icon-nav menu-settings"></i>'.html_safe, edit_admin_site_page_path(site, item), {:remote => true, 'data-target' => "#myModal", class: 'settings-button'}
    elsif class_name ==  "Link" 
      link_to '<i class="icon-nav menu-settings"></i>'.html_safe, edit_admin_site_link_path(site, item), {:remote => true, 'data-target' => "#myModal", class: 'settings-button'}
    elsif class_name ==  "Folder" 
      link_to '<i class="icon-nav menu-settings"></i>'.html_safe, edit_admin_site_folder_path(site, item), {:remote => true, 'data-target' => "#myModal", class: 'settings-button'}
    elsif class_name ==  "Gallery" 
      link_to '<i class="icon-nav menu-settings"></i>'.html_safe, edit_admin_site_gallery_path(site, item), {:remote => true, 'data-target' => "#myModal", class: 'settings-button'}
    end
  end

end
