class BuildsDatatable < Datatable

  delegate :params, :h, :link_to, :build_path, :model_path, to: :@view

  def model_class
    "Genome::Build"
  end

  def data
    objects.map do |build|
      [
        link_to(build.id, build_path(build)),
        build.master_event.event_status,
        link_to(build.model.name, model_path(build.model)),
      ]
    end
  end

  def sort_column
    columns = %w[model.build.build_id model.event.event_status model.model.name]
    columns[params[:iSortCol_0].to_i]
  end

  def scope
    super.eager_load(:master_event, :model)
  end

  def searchable_columns
    %w[model.build.build_id model.event.event_status model.model.name]
  end

end