module HousingAutosuggester
  def self.get_service_url(service)
    {
      "search" => "https://buy.dev.housing.com/",
      "regions" => "https://regions.dev.housing.com/"
    }[service]
  end
end
require "housing_autosuggester/autosuggester_input.rb"