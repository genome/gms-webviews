class InstrumentDataPresenter
  include Mixins::PresenterWithModelPassthrough
  include Mixins::PresenterWithAttributes

  def initialize(id)
    @instrument_data = Genome::InstrumentData.find_for_instrument_data_page(id)
  end

  def library
    @library ||= @instrument_data.library
  end

  def library_name
    library.full_name
  end

  def taxon
    library.taxon
  end

  def taxon_name
    taxon.name
  end


  private
  def model_object
    @instrument_data
  end

  def attribute_pairs
    @attributes ||= @instrument_data.instrument_data_attributes.inject({}) do |attributes, attribute|
      attributes[attribute.attribute_label] = attribute.attribute_value
      attributes
    end
  end
end
