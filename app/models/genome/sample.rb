class Genome::Sample < Genome::Subject
  def taxon
    taxon_id = self.subject_attributes.select{|a| a.attribute_label == 'taxon_id'}.first
    if taxon_id
      Genome::Taxon.find(taxon_id.attribute_value) if taxon_id
    else
      nil
    end
  end
end
