class Genome::Library < ActiveRecord::Base
  self.table_name = 'fragment_library'
  self.primary_key = 'library_id'

  belongs_to :sample, class_name: "Subject", foreign_key: "sample_id"

  def taxon
    #taxon could be on the library's sample, or one level higher
    #if there is a population group or individual record
    taxon = self.sample.taxon
    taxon = self.sample.subject.taxon unless taxon
    taxon
  end

  class << self
    def find_for_library_page(id)
      where(library_id: id).includes(sample: [:models]).first
    end
  end
end
