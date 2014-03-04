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

  def scope
    super.eager_load(:library)
  end

  def sort_column
    columns = %w[instrument.data.id instrument.fragment_library.full_name]
    columns[params[:iSortCol_0].to_i]
  end

  def searchable_columns
    %w[instrument.data.id instrument.fragment_library.full_name]
  end

end
