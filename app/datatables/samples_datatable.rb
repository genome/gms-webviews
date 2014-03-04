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
    columns = %w[subject.subject.name]
    columns[params[:iSortCol_0].to_i]
  end

  def searchable_columns
    %w[subject.subject.name]
  end
end
