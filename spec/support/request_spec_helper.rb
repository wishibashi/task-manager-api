module RequestSpecHelper
    def json_body
        @json_body ||= JSON.parse(response.body, symbolize_names: true) # ||= se variável nula atribua...
    end
end