class ModelsDatatable
  
  delegate :params, :h, :link_to, :model_path, :processing_profile_path, to: :@view
  
  def initialize(view)
    @view = view
  end

  def as_json(options={})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Genome::Model.count,
      iTotalDisplayRecords: models.total_entries,
      aaData:data
    }
  end
  
  def data
    models.map do |model|
      [
        link_to(model.name, model_path(model)),
        link_to(model.processing_profile.name, processing_profile_path(model.processing_profile))
      ]
    end
  end
  
  def models
    @models ||= fetch_models
  end
  
  def fetch_models
    models = Genome::Model.order("#{sort_column} #{sort_direction}")
    models = models.page(page).per_page(per_page)
    if params[:sSearch].present?
      models = models.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    
    models
  end
  
  def page
      params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name processing_profile]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end