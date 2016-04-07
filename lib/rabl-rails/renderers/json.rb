module RablRails
  module Renderers
    module JSON
      include Renderers::Hash
      extend self

      def format_output(hash, options = {})
        if options[:object_root] && hash.is_a?(Array)
          hash = hash.map { |h| { options[:object_root] => h } }
        end

        hash = { options[:root_name] => hash } if options[:root_name] && RablRails.configuration.include_json_root
        json = RablRails.configuration.json_engine.dump(hash)
        params = options.fetch(:params, {})

        RablRails.configuration.enable_jsonp_callbacks && params.has_key?(:callback) ? "#{params[:callback]}(#{json})" : json
      end

      def resolve_cache_key(key, data)
        "#{super}.json"
      end
    end
  end
end