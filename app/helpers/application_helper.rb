module ApplicationHelper
	def booleanize(str)
		begin
			if str.downcase.include? "y"
				true
			else
				false
			end
		rescue
			nil
		end
	end

	def is_active?(path)
		request.path.include? path
	end
end

class String
  def is_number?
    true if Float(self) rescue false
  end
end