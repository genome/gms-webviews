class BuildInputsPresenter
  include Mixins::PresenterWithAttributes

  def initialize(build_inputs)
    @build_inputs = build_inputs
  end

  def attribute_pairs
    @build_inputs.inject({}) do |attributes, attribute|
      attributes[attribute.name] = ->(b) { render_value_for_model_or_build_input(attribute) }
      attributes
    end
  end

  def model_object
    @build_inputs
  end

end
