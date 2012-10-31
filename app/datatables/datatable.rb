class Datatable
  
  def model_class
    "DefineThisInYourSubclassToStopThisFromCrashing"
  end
  
  def initialize(view)
    @view = view
  end
  
  def as_json(options={})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: model_class_object.count,
      iTotalDisplayRecords: objects.total_entries,
      aaData:data
    }
  end  
  
  def objects
    @objects ||= fetch_objects
  end
  
  def fetch_objects
    objects = model_class_object.order("#{model_class_object.table_name}.#{sort_column} #{sort_direction}")
    objects = objects.page(page).per_page(per_page)
    if params[:sSearch].present?
      objects = objects.where("lower(#{model_class_object.table_name}.name) like lower(:search)", search: "%#{params[:sSearch]}%")
    end
    
    objects
  end
  
  
  def page
      params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end
  
  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end  
  
  private
    def model_class_object
      self.model_class.constantize
    end
  end
