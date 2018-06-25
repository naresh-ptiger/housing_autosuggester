module HousingAutosuggester
  module AutosuggesterHelper
    SUGGESTION_HASH = {
      ["Building"] => {
        service: "search",
        version: "v1",
        url: "api/version/search/suggest/?type=regions&region_super_type=building",
        query_param: "string"
      },
      ["Locality"] => {
        service: "regions",
        version: "v1",
        url: "/api/version/polygon/suggest?service_type=buy&feature_type=locality",
        query_param: "input"
      },
      ["Project"] => {
        service: "search",
        version: "v1",
        url: "api/version/search/suggest/?type=project",
        query_param: "string"
      },
      ["User"] => {
        service: "client",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Building", "Locality"] => {
        service: "regions",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Building", "Project"] => {
        service: "search",
        version: "v1",
        url: "api/version/search/suggest/?type=project&region_super_type=building",
        query_param: "string"
      },
      ["Building", "User"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Locality", "Project"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Locality", "User"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Project", "User"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Building", "Locality", "Project"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Building", "Locality", "User"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      },
      ["Building", "Locality", "Project", "User"] => {
        service: "search",
        version: "v1",
        url: "",
        query_param: ""
      }
    }

    def autosuggest(rendered_input, autosuggestid, models, callback_names, version = nil)
      url = (HousingAutosuggester.get_service_url(SUGGESTION_HASH[models.sort][:service]) + SUGGESTION_HASH[models.sort][:url]).gsub("version", (version || SUGGESTION_HASH[models.sort][:version]))
      query_param = SUGGESTION_HASH[models.sort][:query_param]
      rendered_input += raw "<script type='text/javascript'>"
      rendered_input += raw "$(document).on('ready', function(){
        $(\"[data-autosuggestid=\'#{autosuggestid}\']\").tokenInput('#{url}', {
          queryParam: '#{query_param}',
          tokenLimit: 1,
          resultsLimit: 100,
          zindex: 9999,
          theme: 'facebook'"
      if callback_names[:onAdd]
        rendered_input += raw ",
          onAdd: window['#{callback_names[:onAdd]}']
        "
      end
      if callback_names[:onDelete]
        rendered_input += raw ",
          onDelete: window['#{callback_names[:onDelete]}']
        "
      end
      if callback_names[:onResult]
        rendered_input += raw ",
          onResult: window['#{callback_names[:onResult]}']
        "
      end
      if callback_names[:prePopulate]
        rendered_input += raw ",
          prePopulate: window['#{callback_names[:prePopulate]}']()
        "
      end
      rendered_input += raw "
        });
      })"
      rendered_input += raw "</script>"
      return rendered_input.html_safe
    end
  end
end
