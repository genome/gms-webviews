class SubjectPresenter
  include Mixins::PresenterWithModelPassthrough
  include Mixins::PresenterWithAttributes

  def initialize(subject)
    @subject = subject
  end

  def taxon
    @taxon ||= @subject.taxon if @subject.respond_to?(:taxon)
  end

  def library
    if @subject.libraries
      @library ||= @subject.libraries.first
    else
      nil
    end
  end

  def library_name
    library.full_name
  end

  def taxon_name
    taxon.name
  end

  def model_object
    @subject
  end

  def show_taxon_library_div?
    library || taxon
  end

  def show_models_and_builds?
    case @subject
    when Genome::Taxon
      false
    else
      true
    end
  end

  private
  def attribute_pairs
    @attributes ||= @subject.subject_attributes.inject({}) do |attributes,attribute|
      attributes[attribute.attribute_label] = attribute.attribute_value
      attributes
    end
  end
end
