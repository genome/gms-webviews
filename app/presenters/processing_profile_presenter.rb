class ProcessingProfilePresenter
  include Mixins::PresenterWithModelPassthrough
  include Mixins::PresenterWithAttributes

  def initialize(pp)
    @processing_profile = pp
  end

  private
  def model_object
    @processing_profile
  end

  def attribute_pairs
    @pairs ||= @processing_profile.processing_profile_params.inject({}) do |attribute_list, param|
      attribute_list[param.param_name] = ->(pp) {param_value(param)}
      attribute_list
    end
  end

  def param_value(param)
    if param.param_name == 'reference_sequence_model_id'
      link_span(param.param_value, model_path(param.param_value))
    else
        param.param_value
    end
  end

end
