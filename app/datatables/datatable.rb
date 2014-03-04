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
    objects = scope.order("#{sort_column} #{sort_direction}")
    objects = objects.page(page).per_page(per_page)
    if params[:sSearch].present?
      objects = objects.where(search_string, search: "%#{params[:sSearch]}%")
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

  def scope
    model_class_object
  end

  private
  def model_class_object
    self.model_class.constantize
  end

  def search_string
    searchable_columns.map { |col| "lower(#{col}) like lower(:search)" }.join(' OR ')
  end

  def searchable_columns
    []
  end
  end
