class InstrumentDataDatatable < Datatable
  
  delegate :params, :h, :link_to, :instrument_data_path, to: :@view
  
  def model_class
    "Genome::InstrumentData"
  end
    
  def data
    objects.map do |instr_data|
      [
        link_to(instr_data.id, instrument_data_path(instr_data)),
        h(instr_data.library.full_name)
      ]
    end
  end

  def fetch_objects
    objects = model_class_object.order("#{sort_column} #{sort_direction}").joins(:library)
    objects = objects.page(page).per_page(per_page)
    if params[:sSearch].present?
      objects = objects.where("lower(id) like lower(:search) or lower(fragment_library.full_name) like lower(:search)", search: "%#{params[:sSearch]}%")
    end
    
    objects
  end
  
  def sort_column
    columns = %w[id library_id]
    columns[params[:iSortCol_0].to_i]
  end

end
