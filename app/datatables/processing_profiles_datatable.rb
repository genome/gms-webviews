class ProcessingProfilesDatatable < Datatable

  delegate :params, :h, :link_to, :processing_profile_path, to: :@view

  def model_class
    "Genome::ProcessingProfile"
  end

  def data
    objects.map do |pp|
      [
        link_to(pp.name, processing_profile_path(pp)),
      ]
    end
  end

  def sort_column
    columns = %w[model.processing_profile.name]
    columns[params[:iSortCol_0].to_i]
  end

  def searchable_columns
    %w[model.processing_profile.name]
  end

end