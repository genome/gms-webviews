class SamplesDatatable < Datatable
  
  delegate :params, :h, :link_to, :sample_path, to: :@view
  
  def model_class
    "Genome::Subject"
  end
    
  def data
    objects.map do |sample|
      [
        link_to(sample.name, sample_path(sample)),
      ]
    end
  end
  
  def sort_column
    columns = %w[name]
    columns[params[:iSortCol_0].to_i]
  end

end
