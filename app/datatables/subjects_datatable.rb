class SubjectsDatatable < Datatable
  
  delegate :params, :h, :link_to, :subject_path, to: :@view
  
  def model_class
    "Genome::Subject"
  end
    
  def data
    objects.map do |subject|
      [
        link_to(subject.name, subject_path(subject)),
      ]
    end
  end
  
  def sort_column
    columns = %w[name]
    columns[params[:iSortCol_0].to_i]
  end

end
