class ModelsDatatable < Datatable
  
  delegate :params, :h, :link_to, :model_path, :processing_profile_path, to: :@view
  
  def model_class
    "Genome::Model"
  end
    
  def data
    objects.map do |model|
      [
        link_to(model.name, model_path(model)),
        link_to(model.processing_profile.name, processing_profile_path(model.processing_profile))
      ]
    end
  end
  
  def sort_column
    columns = %w[name processing_profile_id]
    columns[params[:iSortCol_0].to_i]
  end

end