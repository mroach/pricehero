class PriorityInput < SimpleForm::Inputs::PriorityInput
  def input_html_classes
    super.push('ui search selection dropdown')
  end
end
