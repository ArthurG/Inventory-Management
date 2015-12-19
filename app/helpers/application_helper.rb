module ApplicationHelper
	def full_title(page = '')
		return  "RoR Inventory Management" if  page.empty?

		"#{page} | RoR Inventory Management"
	end
end
