require "autosuggester_helper.rb"
class AutosuggesterInput < SimpleForm::Inputs::Base
  include HousingAutosuggester::AutosuggesterHelper
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:data] ||= {}
    autosuggestid = SecureRandom.hex(5)
    merged_input_options[:data][:autosuggestid] = autosuggestid
    models = merged_input_options.delete(:models)
    callback_names = merged_input_options.delete(:callback_names)
    api_version = merged_input_options.delete(:version)
    autosuggest(@builder.text_field(attribute_name, merged_input_options), autosuggestid, models, callback_names, api_version)
  end
end