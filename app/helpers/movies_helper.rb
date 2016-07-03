module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  #Highlight selected field to sort 
  def helper_class(field)
 	  if(params[:sort_param].to_s == field)
   		return 'hilite'
	  else
   		return nil
	  end
  end

end
