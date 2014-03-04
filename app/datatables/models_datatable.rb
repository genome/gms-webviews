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

  def scope
    super.eager_load(:processing_profile)
  end

  def sort_column
    columns = %w[model.model.name model.processing_profile.name]
    columns[params[:iSortCol_0].to_i]
  end

  def searchable_columns
    %w[model.model.name model.processing_profile.name]
  end

end