class SubjectPresenter
  include Mixins::PresenterWithModelPassthrough
  include Mixins::PresenterWithAttributes

  def initialize(id, opts = {})
    case opts[:controller]
    when :taxon
      @subject = Genome::Subject.where(subject_id: id).with_attributes.first
    else
      @subject = Genome::Subject.where(subject_id: id).with_models_and_builds.with_attributes.with_libraries.first
    end
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

  def model_object
    @subject
  end

  private
  def attribute_pairs
    @attributes ||= @subject.subject_attributes.inject({}) do |attributes,attribute|
      attributes[attribute.attribute_label] = attribute.attribute_value
      attributes
    end
  end
end
